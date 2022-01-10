Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F35489D39
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jan 2022 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiAJQMi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jan 2022 11:12:38 -0500
Received: from mail-centralusazon11021018.outbound.protection.outlook.com ([52.101.62.18]:23029
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237092AbiAJQMc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jan 2022 11:12:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0Mbjfvg2cAra7Duv5iAJsKi7aRELluMgnT46sV6OLMDdRLtNl6Ux/rX5RDXTu6fXFEB1VghkwqBTKUo8WIfwsuJga6EntIHPaxdATXBofFLUBQSyUsoZBmlzXYTCLy5ckC+SIJOala6w9uiSbKzbe7p72oDsdsWcdRd2ozIGS7oUQKsxDv8ovOwz0KI7ZYqYq41Fcxgq+pFnK1rnwGC4tFeRk1tiYF89bU5nh3Sj87UmJPddmneNFFuKF7p3jI8HGkVVlkwCXjscsL3dzT9Go4dDY3gi8wNO9nPHit0MpSTUYmvZxlxDCIdtvEfZR9DqIjhqE7UQlMrix0KroAEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAv7BkumN7DhxsMIQhcVzCN8OMCfElmuwxaZore7r04=;
 b=PAdLs06yrmcZZIS/3PUNdIjNyFN6VR7Pxrkf2R2je5dwzn4dOng4O3jT0noodJGboUnDOoZaSi8xrUjF+hGLRqjuwDOkmyxk8YCAwt9Yy+kJFUm0rZWEkyX0lvUnhaKR7lyRhBF751L6EqwrPkPHYlXf0EyppvbVwvGJvMiQakZesc/EmhGi1urGGbmggbMQdHnbyQfKAphIaKEZyax9/VBLpFERZRJ6ZS4UhEjSukltDcdEItmtB1NdfVyrxCx750cDHab9gYePRh8c5jghpIwETnzEhmHpNUqCn1JG/Y21yOX4rHhmWfKifv4Xo/fMAr8BpAzl6BzGh0RMiVRXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAv7BkumN7DhxsMIQhcVzCN8OMCfElmuwxaZore7r04=;
 b=c0pUBUB9PqGjHbPjtcgEO+GDWQ3hWLj5A8sLsl+C+zqEZY7Q/w4VebtgRtWGBbcye3A/yScAfAyixPK6JaQSthx1OD1EmhOfFb7pmaU1mC4mXmv+8vexh2X2bsikZSSLhAiL66VJnoKc/9UVM88XBCN2qSfABd7ybP7WlaxsZBs=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1852.namprd21.prod.outlook.com (2603:10b6:302:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.1; Mon, 10 Jan
 2022 16:12:29 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::7478:bb68:bc94:3312]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::7478:bb68:bc94:3312%3]) with mapi id 15.20.4909.001; Mon, 10 Jan 2022
 16:12:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with
 parameters affecting NUMA topology
Thread-Topic: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with
 parameters affecting NUMA topology
Thread-Index: AQHYA1QWURfWxy//0UuSygYpK/bNEqxXrRcQgABXZwCABGe4cA==
Date:   Mon, 10 Jan 2022 16:12:29 +0000
Message-ID: <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 922e0c16-fe38-4aa6-0b2e-08d9d4540051
x-ms-traffictypediagnostic: MW2PR2101MB1852:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB1852AC656E59C373AF0E26FCD7509@MW2PR2101MB1852.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNC6ayS/GtTWQl4fg+Y2MBq81ACxhLZNvjo8fma1x9615c+L77UAU6ZOQrqotS+/WGqeW4MkdImNb2oFQ75zvy4vHqqV960PBlM/Gb6DY0qFm0rh5KYRYdU/vPz1Zoq9RQEbIYrmZ65MNYQf/Brov8c7mNaqCBzbo70axL3ZeEadzwPsxUfM0fJzmc7cHEHZynt4kSLt2h+t9ZRd4bVPhHMNJk1S9PSC66MSUOuWSR0h5zsTuF4/jVhoriZvtWTXng5mNvbo6BOBq2j82tnZfd7wV1gOyepTPBfuIadM0iR5bF8U/xsZH15gk5ngWu2MmX4H4L4o5+1xTRRXgov50Nk5PUja3yQzjU8Sjfjvz3YH9VCknRyxdkkkxyDv7HultJhEVSRkOZz58qy2H7R0+mhTEHX2d7Ge62PrK0JjhriIreNKHr/QU3ehugS6sed15VqJeqFn04I4l42IlQ/no7EoeyZaSjBtMxRCgKvQpvyKtT9DMvWJRk5ZI6UJi/xtYmmaPcggLb0/UjH5PwyNHE7tIessAGG1UWcCzAqzIT3PPXGGteLIGUKasFqB7JD9tmtInBtoJ9v4w6PdnCK+6XjexqGRuaacNFlzgK/rOQZfqGFuuVrVpPvBXC34j1XSEmZ8zmVQUAj+UmwsJL0cwzU50Zel652xtOni9/4Wm04juHRziKNtynVDl96690IJCue5bBSRNMdKvYRD7OKC68EdGo863jDQ4fsfxwH8oLQ+nbDo3FTbquV7EYCjwmsF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(83380400001)(26005)(52536014)(76116006)(5660300002)(186003)(55016003)(6636002)(316002)(110136005)(2906002)(8676002)(8936002)(66556008)(64756008)(66446008)(66476007)(66946007)(8990500004)(10290500003)(9686003)(7696005)(6506007)(71200400001)(122000001)(508600001)(82950400001)(82960400001)(38070700005)(38100700002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3Qy4vCiywJl+YWlee38hlIcO0nTi6iy4nf5/PMV3qk09WdSBia175wH8bmd?=
 =?us-ascii?Q?myQHId6GSZ2aKfx0d118Jc3SCmDkGxddHJXR3EFEp0e3VsSfkBBgbx5Np53/?=
 =?us-ascii?Q?cx1+kInktiIgATpnMJB/GLI09KtcdJ9XvrC2r1JYoxerYiWHJHgrbySV5xGU?=
 =?us-ascii?Q?lpdOKhp+7JhHAXU9/fuG0GLn+hW+NwzGzOmQD514O/iF6K2W+sds1XH2EHlD?=
 =?us-ascii?Q?xrUSxcjfL7UbgPC63SfEkI/ucAdjJ9DZTYFq+VU9riGDHEjcPjNcQitc//Wq?=
 =?us-ascii?Q?Sj5Ctwrbo+FRzs9cwNR2gRYYXrbzo7+gkRNhRWuelnVm3Mq20EylAB91vBzl?=
 =?us-ascii?Q?sEFz2tgGNnaS4UhlEBvqhZ6jJBaPxjbFObqm+tJn9QRsHMqeTfRi+AIWeLOd?=
 =?us-ascii?Q?KQDeOgyOKdOhdzKZ8J7VDjCV+4+9pKZNlRIuGOxMU3j+JQmVb/MuvX/bOUON?=
 =?us-ascii?Q?qGz0mi2I8UuBCg6Fedp5NYu8c0CFOHF25RUGf7iSKdF+gdoDBn/ArBHFdLnk?=
 =?us-ascii?Q?sE97G1+BsiwJ3/blkZDBPrUxki4DeSMP7R/cU9gW2grjzG3RNIEimBK6B7sE?=
 =?us-ascii?Q?vVYwDKf4ffKu2XURiSrjHYk3H/f29GyCxf8Wpw153tYv7nVXdqf49xpYXGJX?=
 =?us-ascii?Q?mUhejr41MWjVqArcnqq8CO7rqQzbtMXKJPnzJPYDUQ5uSKzxxeAS9LGpc30G?=
 =?us-ascii?Q?XkmFnv6ltjugbO3F7xu2RgFPeAGSUB9I3YXayda4rJYHiUURy/vYaUHUsDH8?=
 =?us-ascii?Q?8d+QiKSc33EssrMkXogFyKYx4mOFTKEBy7oFhoPz+hqJiRs6uGhcJAvraLhr?=
 =?us-ascii?Q?dn60e0jRPlHrgi+ksHXhQeyLnrkg4BF4s7Ya6OlzliU6bK8K6zPepTyfcHp/?=
 =?us-ascii?Q?Um3LYxwfZx0OmCWm2lrvXp0YeYUhux7vLvNdxV142JFutY4OH8+1FHYpf/rr?=
 =?us-ascii?Q?PGbzNjv/bP+69WXIKf7Gfja1oBm/bSJpm6PP11X/3YOs8n7spHHQ/XsB8j80?=
 =?us-ascii?Q?zOdJ2vsC0PP39o/pueb72r+5fonuElAJKxvZn12KFf4+8Z7Khu6DMA3+FoRB?=
 =?us-ascii?Q?IoQTb7z2e5oSrG2c4a8EDiK7BopxIb262eBobUItnQsoehFL8t/1K3PmEV0O?=
 =?us-ascii?Q?yIrazqsY3rLKrdiral31z1oz5UNWLesP5m5UBH7tbghHF84i3Lxg8plzkMzW?=
 =?us-ascii?Q?yVO/7+MiApbCgNb27Ww52l3vnc4Wy9vBnez5ZR/Vzm1t+6Syqbftxd8QqlsW?=
 =?us-ascii?Q?/ufhlyEJTpZ+v3o1R5+r8W84WvNM2cAh5i4x9B9cGXrw7OfNQ929atSfGnSR?=
 =?us-ascii?Q?CyRgogGT6aULFB+BdQz68K7r3365aQy/zZM2nw0frpUcN5i4UiFaTpZ0Okib?=
 =?us-ascii?Q?Avu1fwvbL2ITzSUXBh7GPbWAwB7VDr8YyEPn5R1YNr7xF7Ss1B/FDhJhMDVV?=
 =?us-ascii?Q?eyIyqCAVFIo3gTBdAfBonjT9lD8ot2jCPU9QA73LbxdGOH1Xjae9Re9Gw/hv?=
 =?us-ascii?Q?K7qzb9dWxx+Wrz+s3Au4tchPnlceXF9Fsjpt7SpAY/8/6xDqMecdlVq8dOzB?=
 =?us-ascii?Q?nsdTQIlIR1mZotJj+QnimshjLMAOS+9sZDBObrNbg22ttfssXUHmAcCLmDO8?=
 =?us-ascii?Q?q9RW3B0xBQyPih89lV3d4p0i0fAOMy31RLDQwyy0tDMD5W5HsHWZCQ0M23CV?=
 =?us-ascii?Q?ZScX7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e0c16-fe38-4aa6-0b2e-08d9d4540051
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 16:12:29.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VoDCC1E3tLZMmOJuloXKhZqjXWST3woG9SvhyF0Q9/xJ2TagPQL1oSJTQLdmbIUSE3Q3x4lMpxYLlIuNclIcT/M3bbn6EnJxBT+p/dB7OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1852
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Friday, January 7, 2022 12:32 PM
> >
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> > Thursday, January 6, 2022 3:20 PM
> > >
> > > When the kernel boots with parameters restricting the number of cpus
> > > or NUMA nodes, e.g. maxcpus=3DX or numa=3Doff, the vPCI driver should=
 only
> > > set to the NUMA node to a value that is valid in the current running =
kernel.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > b/drivers/pci/controller/pci- hyperv.c index
> > > fc1a29acadbb..8686343eff4c 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -1835,8 +1835,21 @@ static void hv_pci_assign_numa_node(struct
> > > hv_pcibus_device *hbus)
> > >  		if (!hv_dev)
> > >  			continue;
> > >
> > > -		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> > > +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > > +			int cpu;
> > > +			bool found_node =3D false;
> > > +
> > > +			for_each_possible_cpu(cpu)
> > > +				if (cpu_to_node(cpu) =3D=3D
> > > +				    hv_dev->desc.virtual_numa_node) {
> > > +					found_node =3D true;
> > > +					break;
> > > +				}
> > > +
> > > +			if (found_node)
> > > +				set_dev_node(&dev->dev,
> > > +					     hv_dev->desc.virtual_numa_node);
> > > +		}
> >
> > I'm wondering about this approach vs. just comparing against nr_node_id=
s.
> =09
> I was trying to fix this by comparing with nr_node_ids. This worked for
> numa=3Doff, but it didn't work with maxcpus=3DX.
>=20
> maxcpus=3DX is commonly used in kdump kernels. In this config,  the memor=
y
> system is initialized in a way that only the NUMA nodes within maxcpus ar=
e
> setup and can be used by the drivers.

In looking at a 5.16 kernel running in a Hyper-V VM on two NUMA
nodes, the number of NUMA nodes configured in the kernel is not
affected by maxcpus=3D on the kernel boot line.  This VM has 48 vCPUs
and 2 NUMA nodes, and is Generation 2.  Even with maxcpus=3D4 or
maxcpus=3D1, these lines are output during boot:

[    0.238953] NODE_DATA(0) allocated [mem 0x7edffd5000-0x7edfffffff]
[    0.241397] NODE_DATA(1) allocated [mem 0xfcdffd4000-0xfcdfffefff]

and

[    0.280039] Initmem setup node 0 [mem 0x0000000000001000-0x0000007edffff=
fff]
[    0.282869] Initmem setup node 1 [mem 0x0000007ee0000000-0x000000fcdffff=
fff]

It's perfectly legit to have a NUMA node with memory but no CPUs.  The
memory assigned to the NUMA node is determined by the ACPI SRAT.  So=20
I'm wondering what is causing the kdump issue you see.  Or maybe the
behavior of older kernels is different.

>=20
> > Comparing against nr_node_ids would handle the case of numa=3Doff on th=
e
> > kernel boot line, or a kernel built with CONFIG_NUMA=3Dn, or the use of
> > numa=3Dfake.  Your approach is also affected by which CPUs are online, =
since
> > cpu_to_node() references percpu data.  It would seem to produce more
> > variable results since CPUs can go online and offline while the VM is r=
unning.
> > If a network VF device was removed and re-added, the results of your
> > algorithm could be different for the re-add, depending on which CPUs we=
re
> > online at the time.
> >
> > My impression (which may be incorrect) is that the device numa_node is
> > primarily to allow the driver to allocate memory from the closest NUMA =
node,
> > and such memory allocations don't really need to be affected by which C=
PUs
> > are online.
>=20
> Yes, this is the reason I'm using for_each_possible_cpu(). Even if some C=
PUs
> are not online, the memory system is setup in a way that allow driver to
> allocate memory on that NUMA node. The algorithm guarantees the value of
> NUMA node is valid when calling set_dev_node().
>=20

I'm thinking the code here should check against nr_node_ids, to catch the
numa=3Doff  or CONFIG_NUMA=3Dn cases.  Then could use either node_online()
or numa_map_to_online_node(), but I'm still curious as to how we would
get an offline NUMA node given how Hyper-V normally sets up a VM.

NUMA nodes only transition from online to offline if there are no CPUs
or memory assigned.  That can happen if the CPUs are taken offline (or
never came online) and if the memory is hot-removed.  We don't currently
support hot-remove memory in Hyper-V VMs, though there has been
some discussion about adding it.  I'm not sure how that case is supposed
to be handled if the NUMA node is stashed in some device and get used
during dma_alloc_coherent(), for example.  That seems to be a general
Linux problem unless there's a mechanism for handling it that I haven't
noticed.

Michael

