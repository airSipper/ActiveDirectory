#!/usr/bin/env python3

# Creates a direction graph of nodes. Script will ask the user
# if one node can talk to another and will then plot the info

from matplotlib import pyplot as plt
import networkx


nodes = {}
node_names = []

# colours here are from matplotlib, add more if you need to
colours = ['skyblue', 'slategray', 'seagreen', 'violet', 'blueviolet',
           'darkkhaki', 'sienna', 'darkygray', 'lightsteelblue', 'darkcyan']


def create_nodes():
    # create n nodes
    try:
        node_num = int(input("Number of nodes? : "))
    except ValueError:
        print("Not valid input. Quitting....")
        exit(0)

    for i in range(node_num):
        node_names.append(str(input("Node name: ")))

    for i in range(len(node_names)):
        for j in node_names:

            # let's not ask if a node can talk to itself
            if node_names[i] != j:

                _ = input(f"Can {node_names[i]} talk to {j}?: ")

                # Check if node exists, if not, we create it
                if _ == "yes" and node_names[i] not in nodes.keys():
                    nodes[node_names[i]] = [j]

                elif _ == "yes" and node_names[i] in nodes.keys():
                    nodes[node_names[i]].append(j)

                elif _ == "no":
                    pass
                else:
                    print("Error. Quitting...")
                    exit(1)
            else:
                pass


def gen_edges(nodes):

    edges = []

    for i in nodes:
        # if it can talk to another node
        for neighbour in nodes[i]:

            # add it to the list of links
            edges.append((i, neighbour))

    return edges


def gen_graph(node_names, colours):

    labels = {}

    # create the graph object
    g = networkx.MultiDiGraph()

    # add the nodes to it
    for name in node_names:
        g.add_node(name)

    pos = networkx.spring_layout(g)

    # draw our coloured nodes
    for i in range(len(node_names)):
        networkx.draw_networkx_nodes(g, pos, nodelist=[node_names[i]], node_color=colours[i])

    # draw the arrows to and from
    networkx.draw_networkx_edges(g, pos, edgelist=gen_edges(nodes), arrowsize=20)

    for name in node_names:
        labels[name] = name

    # label them
    networkx.draw_networkx_labels(g, pos, labels, font_size=20, font_color="darkgray")

    plt.axis('off')
    plt.show()


if __name__ == "__main__":
    create_nodes()
    gen_graph(node_names, colours)
