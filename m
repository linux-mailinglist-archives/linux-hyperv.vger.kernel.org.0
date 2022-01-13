Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53248CFDF
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 01:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiAMA7T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 19:59:19 -0500
Received: from mail-eus2azon11021021.outbound.protection.outlook.com ([52.101.57.21]:39765
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbiAMA7Q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 19:59:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoToryFiQIb79XySPK75mf9pURtgNDmgf6fcOgj3lURGWMgPZdEFVZE7CHl910NOzrmWOYBgF+6a3d2b5wONxHls0CaGQvjRe7A30Hw2N4dfNlMKovWClgOxaBThveMJlh6ENcAOQ9hH4pP4NnYGfl+ExyngV98RKeuWYU2eXOpefodtEQ0QlP4Zgxzdo2wr2gaRQjamXDoXCUeq2S5S/N+Z+09IWHa0zDqvxxU5zOPXlVAsVx+cuvP/TvbtFlM4PGeezem29lL1HvBkP1YCFPQwIJAH+NYPRbUP1MaxBhxNpa8+v/iZaBYi4v7TufgUTC2uHfmLSDMgxIhUKWW+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2ooEMpqEDYl3z4XFJR3z5m6ze3k5gtsr/7za57TOi0=;
 b=Oxko6mnxCAy+fZ97nPdgmRjKDuAaXyiEkBPMHqbsz8AiaeRZfS4qjxFljMBBFjbYyHoGl+2QT68Xxe7g2/vIrHmwkPE/N8XOtMzWYT8t7L9pSRQ0jraK9ZNqVRHnWq/4egmAQJNA1ezJoP97N56gpZvSbTHhhzc5fJ3hfFTjA3S8eJV/i5C4TTZS1sMK3d3s0PnGby/a+uRmxvQWnKCRWmpCBRbKEcNbGFiHk2QMJREGgBOEU23D15U2qYCZu4CtTIBalPRBAtccEcwJYprbMAB1xR80VYiZ57QryX9Tpfk0I3EN2/+xI42zDN4wE8z82uAQ/74A7fHCGOK+dbq8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2ooEMpqEDYl3z4XFJR3z5m6ze3k5gtsr/7za57TOi0=;
 b=VaYz/QmF4n8k+X2zrdxZxPgp0Iyny1m/2cuyZ42aQ8spZnozPIrVi/owc5X2MvGZKpbAnFr5u09HhDIeCtn9vKE4BFR82P42euWM+cWaanR8X6XcW3FARalR76dG2or8KG4z2s9tGUG3a/QZukxXVK1mBAa8RV46PbTjVXmNNsA=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by PH0PR21MB1328.namprd21.prod.outlook.com (2603:10b6:510:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.1; Thu, 13 Jan
 2022 00:59:13 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d15d:9006:d21:91e1]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d15d:9006:d21:91e1%5]) with mapi id 15.20.4909.001; Thu, 13 Jan 2022
 00:59:13 +0000
From:   Long Li <longli@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with
 parameters affecting NUMA topology
Thread-Topic: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with
 parameters affecting NUMA topology
Thread-Index: AQHYA1QWLddhPIPNnk6mtn+/LlpFvqxXsWWAgABQoACABHENgIADtXxg
Date:   Thu, 13 Jan 2022 00:59:13 +0000
Message-ID: <BY5PR21MB1506B0D34E7C42B9B0337136CE539@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 915d2d20-7bb7-466a-acaa-08d9d62fea66
x-ms-traffictypediagnostic: PH0PR21MB1328:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB1328989DA04CA26FD18CFE86CE539@PH0PR21MB1328.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcFEiLzS77n+UiPmTQqMYSvSbpZpe+h6tFPk7AACcK1duPjupDl1x5bw/FvMvSlLmHxVaAzYKsXlC3w+TUSMj1ZTWURAR+z+uKDNNkhEOd1FMdOFA9+AGYcChVnZRARq8I6tqDfMRZuLTE4W4bws4roXFR9JhhVXxZopaplsXWj1EzTHuvMmMsQcUeZcJOJ7gW4wK8v1/eFpg3ou0SvLmrtKEQj/9tcg+2QsiOv9rds1RiinX9j2IWNVgDBVLm6Tm9IFEYN9uU8xX/JWwY3sOsjA8mZnTVsRiL/tqF55XmNZw3sLHoOM2ph3HH6Yk9xtPX5WhMQc2HBIyFbrmPSOrd0My8b6d7btgPusZFZfwPLUFwmsNGJGhnTVIPn+5ffahtL/kJ/AesXd7DMgFz/RnP1apsF3dLLEXqofemj/IS2oP0sFaOVcCrpkwMf0DcJoSYXsFjQndNddBxeYxVVNldA641/4gled50nICd3IsbMREKuV7qMPw9QAf8nUTyNzxZ/3g5eRw4Zbvf92HALajJ7CivXy/fTh3gKDQVxckMAfEWW7Vf9OxIyEDRSWdhQgjnPizZtvf0zOgTbPSsTn4abTOTvIj4U9pGYGxame6K9f1BBjqEd2XbibYHjHMTt8M8ZEfDnV55mv3tw8pvdFyKBaX2UUzzBKPkcBDafG4H15cgTuZUPfhs6YZhJY5R21iTBPuBceynTFuwsO9epU4ucfsAnxAuXOKAp38vDFM8nftUFwNYHseakKDggwuFwi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(8990500004)(66446008)(55016003)(71200400001)(83380400001)(66946007)(82950400001)(508600001)(10290500003)(86362001)(6506007)(2906002)(82960400001)(9686003)(38100700002)(33656002)(8676002)(110136005)(6636002)(5660300002)(76116006)(66476007)(316002)(26005)(38070700005)(8936002)(186003)(64756008)(52536014)(66556008)(7696005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/0WZv8vPSbFoF/kihVSlbt/loX7nuf74X04csNu8sZXfHHh1hMuKkTlz8Vjr?=
 =?us-ascii?Q?xfyddE869Z9H4UdZoocQ0vgYZHphraf9B/0xo0TnCtWkmE1mzfkHYu6ZG317?=
 =?us-ascii?Q?OmbyU6Q2+fhapJrNDoUgB6EMhreJy9eEogE9XFlge05hFTrl270lnKWK8LBJ?=
 =?us-ascii?Q?ax6Gzoz+rpCVDWW1tsCB4tNrJQiaKmqZv039qlXArpS3evzOu6YBb2h4r1NZ?=
 =?us-ascii?Q?W42I7xDFT2QAh92ih+KSRTsWXHP0v7Z/+PEUhiO8EfX4NVAR5WQJgCjI7bj8?=
 =?us-ascii?Q?iUsOYPyy1LF6c+5d0Foow1XMTAc4l1HlI+NntkS5TfNYxMI+X9XRikkeRFri?=
 =?us-ascii?Q?bdG66/6fwCop7gObwFDtaHn4tQQbl0XGtpDx2RLWSWJqfKdxZDkCyxxP4t2P?=
 =?us-ascii?Q?AlnjFqcyjuH9O8Lw5n37ka4TgxKAUanvvzuhSfo5acaoUPKYP2I8jIX24GyP?=
 =?us-ascii?Q?BgPi+VcCu6n1F5mCouiihZiX5KoL+WZedHGEfo0Iu+eANLmQuXedgnsNXCnT?=
 =?us-ascii?Q?RX7EErDCbYJl1lwMNlbDpx5ueS9oxRZEmuuT/yOg2EmeFnNioB05bLp5xLfF?=
 =?us-ascii?Q?z3K76WB9Tbgzy/UyO41o535ymfHXIeJIR//oDkUDbHu+diKGouK5q6mriGua?=
 =?us-ascii?Q?lDLuN0WX+cSi91PrIQSGJfHPabyEcEiYX2x5Ms7yFaaCQk7vfRfzrhh9bkdx?=
 =?us-ascii?Q?aHkIgfcgShUhxjl1mudcmbwiRwvotGTTYVuBt6u2oaveyOWiRoj876F0bHqn?=
 =?us-ascii?Q?dxYF0Q6W0+51f1kLlfoDTNjM3bGUQL45bpzY/A+U3b0SLEk/SKDewU7UDYDc?=
 =?us-ascii?Q?Wl5PlN8K2G7wHhg+oeyq/dnByNzbmAIujJQNyBBej7AruoyiSZ4Glgb25pXf?=
 =?us-ascii?Q?UmZo17oUih8jmHIzp9jLQbzHiANh1O2aHdqbLXpSizOhcjxChkTe6HoIAfmJ?=
 =?us-ascii?Q?U6OUtR6upIEKez99R0lrb8doUhhmiDhkuhpfEYVZgt4LDokiFAaofKQa50ga?=
 =?us-ascii?Q?npepxk7T4hthV53/IrIdHa/DqXLnuSFoo0D8WWShmYog7nw8SUe/NHXlSSiR?=
 =?us-ascii?Q?5TkjNT2iYUtFpJtw8bpbIkfV6fPDcEo/Uz1pyZmGxJyu+kp1GPqervktJV1b?=
 =?us-ascii?Q?n/kltoms/MsAc6a7N5wa3n71bL7ON8dyQWL5XQMQc0ZHhffpwFT/LmY+gi29?=
 =?us-ascii?Q?sIeIORvMMy505ah5pezv8OZzaO5o1G7qzMNCy8HAsRkrIRgW8pp66bg9ibqO?=
 =?us-ascii?Q?WZZSBjoHuFVvS2q9RAa8HDnmGQOunwCxNoWOaNaAgP6EdGtlYz7skk8NKdsW?=
 =?us-ascii?Q?UfrJ8z+NRYigpQOcK2Rxs8vzm3jwPLS799dEKACQrBAJR+822/4PwpCIwL0u?=
 =?us-ascii?Q?4SfivohBHvH98094bJ2WvBhwTYMc0fkkKrnQDoNwFdbtmna7/vVgeyUN4g2w?=
 =?us-ascii?Q?WME/j+uBnPax9iXAOyyoPd15gsWNDZ64WeSJFJcEtWKHHeyfCUyxh2wjVtDV?=
 =?us-ascii?Q?gAp2yVGrjdETN8UWCiosici58vNqm/YtCXHTKcf8jUJ2tFD/G16M1mw7Jm0A?=
 =?us-ascii?Q?57AINN++RDySc5RbXMpCyQT80XrAxY1zF0hBQGND8FthaeL3r5TerkiZplZT?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915d2d20-7bb7-466a-acaa-08d9d62fea66
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 00:59:13.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxAdBe7qqXOl98lEC1DXsZSTPqNfVmtYUanw6Tcv7794aAB/3sVGVuPDvc87UzluGVv/up2hx79wdg6/POIcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1328
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots
> with parameters affecting NUMA topology
>=20
> From: Long Li <longli@microsoft.com> Sent: Friday, January 7, 2022 12:32 =
PM
> > >
> > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> > > Thursday, January 6, 2022 3:20 PM
> > > >
> > > > When the kernel boots with parameters restricting the number of
> > > > cpus or NUMA nodes, e.g. maxcpus=3DX or numa=3Doff, the vPCI driver
> > > > should only set to the NUMA node to a value that is valid in the cu=
rrent
> running kernel.
> > > >
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > >  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
> > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > b/drivers/pci/controller/pci- hyperv.c index
> > > > fc1a29acadbb..8686343eff4c 100644
> > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > @@ -1835,8 +1835,21 @@ static void hv_pci_assign_numa_node(struct
> > > > hv_pcibus_device *hbus)
> > > >  		if (!hv_dev)
> > > >  			continue;
> > > >
> > > > -		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > > -			set_dev_node(&dev->dev, hv_dev-
> >desc.virtual_numa_node);
> > > > +		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > > > +			int cpu;
> > > > +			bool found_node =3D false;
> > > > +
> > > > +			for_each_possible_cpu(cpu)
> > > > +				if (cpu_to_node(cpu) =3D=3D
> > > > +				    hv_dev->desc.virtual_numa_node) {
> > > > +					found_node =3D true;
> > > > +					break;
> > > > +				}
> > > > +
> > > > +			if (found_node)
> > > > +				set_dev_node(&dev->dev,
> > > > +					     hv_dev->desc.virtual_numa_node);
> > > > +		}
> > >
> > > I'm wondering about this approach vs. just comparing against nr_node_=
ids.
> >
> > I was trying to fix this by comparing with nr_node_ids. This worked
> > for numa=3Doff, but it didn't work with maxcpus=3DX.
> >
> > maxcpus=3DX is commonly used in kdump kernels. In this config,  the
> > memory system is initialized in a way that only the NUMA nodes within
> > maxcpus are setup and can be used by the drivers.
>=20
> In looking at a 5.16 kernel running in a Hyper-V VM on two NUMA nodes, th=
e
> number of NUMA nodes configured in the kernel is not affected by maxcpus=
=3D on
> the kernel boot line.  This VM has 48 vCPUs and 2 NUMA nodes, and is
> Generation 2.  Even with maxcpus=3D4 or maxcpus=3D1, these lines are outp=
ut during
> boot:
>=20
> [    0.238953] NODE_DATA(0) allocated [mem 0x7edffd5000-0x7edfffffff]
> [    0.241397] NODE_DATA(1) allocated [mem 0xfcdffd4000-0xfcdfffefff]
>=20
> and
>=20
> [    0.280039] Initmem setup node 0 [mem 0x0000000000001000-
> 0x0000007edfffffff]
> [    0.282869] Initmem setup node 1 [mem 0x0000007ee0000000-
> 0x000000fcdfffffff]
>=20
> It's perfectly legit to have a NUMA node with memory but no CPUs.  The
> memory assigned to the NUMA node is determined by the ACPI SRAT.  So I'm
> wondering what is causing the kdump issue you see.  Or maybe the behavior=
 of
> older kernels is different.

Sorry, it turns out I had a typo. It's nr_cpus=3D1 (not maxcpus). But I'm n=
ot sure if that matters as the descriptions on these two in the kernel doc =
are the same.

On my system (4 NUMA nodes) with kdump boot line:  (maybe if you try a VM w=
ith 4 NUMA nodes, you can see the problem)
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.11.0-1025-azure r=
oot=3DPARTUUID=3D7145c36d-e182-43b6-a37e-0b6d18fef8fe ro console=3Dtty1 con=
sole=3DttyS0 earlyprintk=3DttyS0 reset_devices systemd.unit=3Dkdump-tools-d=
ump.service nr_cpus=3D1 irqpoll nousb ata_piix.prefer_ms_hyperv=3D0 elfcore=
hdr=3D4038049140K

I see the following:
[    0.408246] NODE_DATA(0) allocated [mem 0x2cfd6000-0x2cffffff]
[    0.410454] NODE_DATA(3) allocated [mem 0x3c2bef32000-0x3c2bef5bfff]
[    0.413031] Zone ranges:
[    0.414117]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.416522]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.418932]   Normal   [mem 0x0000000100000000-0x000003c2bef5cfff]
[    0.421357]   Device   empty
[    0.422454] Movable zone start for each node
[    0.424109] Early memory node ranges
[    0.425541]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.428050]   node   0: [mem 0x000000001d000000-0x000000002cffffff]
[    0.430547]   node   3: [mem 0x000003c27f000000-0x000003c2bef5cfff]
[    0.432963] Initmem setup node 0 [mem 0x0000000000001000-0x000000002cfff=
fff]
[    0.435695] Initmem setup node 3 [mem 0x000003c27f000000-0x000003c2bef5c=
fff]
[    0.438446] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.439377] On node 0, zone DMA32: 53088 pages in unavailable ranges
[    0.452784] On node 3, zone Normal: 40960 pages in unavailable ranges
[    0.455221] On node 3, zone Normal: 4259 pages in unavailable ranges

It's unclear to me why node 1 and 2 are missing. But I don't think it's a H=
yper-V problem since it's only affected by setting nr_cpus over kernel boot=
 line. Later, a device driver (mlx5 in this example) tries to allocate memo=
ry on node 1 and fails:

[  137.348836] BUG: unable to handle page fault for address: 0000000000001c=
c8
[  137.352224] #PF: supervisor read access in kernel mode
[  137.354884] #PF: error_code(0x0000) - not-present page
[  137.357440] PGD 0 P4D 0=20
[  137.358976] Oops: 0000 [#1] SMP NOPTI
[  137.361072] CPU: 0 PID: 445 Comm: systemd-udevd Not tainted 5.11.0-1025-=
azure #27~20.04.1-Ubuntu
[  137.365160] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.1 10/27/2020
[  137.369915] RIP: 0010:__alloc_pages_nodemask+0x10e/0x300
[  137.372590] Code: ff ff 84 c0 0f 85 21 01 00 00 44 89 e0 48 8b 55 b0 8b =
75 c4 c1 e8 0c 48 8b 7d a8 83 e0 01 88 45 c8 48 85 d2 0f 85 44 01 00 00 <3b=
> 77 08 0f 82 3b 01 00 00 48 89 7d b8 48 8b 07 44 89 e2 81 e2 00
[  137.381311] RSP: 0018:ffffabcd4137b858 EFLAGS: 00010246
[  137.383941] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  137.387397] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00000000000=
01cc0
[  137.390724] RBP: ffffabcd4137b8b0 R08: ffffffffffffffff R09: fffffffffff=
fffff
[  137.394347] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00cc0
[  137.397698] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000000=
00cc0
[  137.401055] FS:  00007fefb6620880(0000) GS:ffff90103ec00000(0000) knlGS:=
0000000000000000
[  137.404970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  137.407888] CR2: 0000000000001cc8 CR3: 000003c280d78000 CR4: 00000000003=
50ef0
[  137.411294] Call Trace:
[  137.412882]  __dma_direct_alloc_pages+0x8e/0x120
[  137.415399]  dma_direct_alloc+0x66/0x2a0
[  137.417517]  dma_alloc_attrs+0x3e/0x50
[  137.419590]  mlx5_cmd_init+0xe5/0x570 [mlx5_core]

>=20
> >
> > > Comparing against nr_node_ids would handle the case of numa=3Doff on
> > > the kernel boot line, or a kernel built with CONFIG_NUMA=3Dn, or the
> > > use of numa=3Dfake.  Your approach is also affected by which CPUs are
> > > online, since
> > > cpu_to_node() references percpu data.  It would seem to produce more
> > > variable results since CPUs can go online and offline while the VM is=
 running.
> > > If a network VF device was removed and re-added, the results of your
> > > algorithm could be different for the re-add, depending on which CPUs
> > > were online at the time.
> > >
> > > My impression (which may be incorrect) is that the device numa_node
> > > is primarily to allow the driver to allocate memory from the closest
> > > NUMA node, and such memory allocations don't really need to be
> > > affected by which CPUs are online.
> >
> > Yes, this is the reason I'm using for_each_possible_cpu(). Even if
> > some CPUs are not online, the memory system is setup in a way that
> > allow driver to allocate memory on that NUMA node. The algorithm
> > guarantees the value of NUMA node is valid when calling set_dev_node().
> >
>=20
> I'm thinking the code here should check against nr_node_ids, to catch the
> numa=3Doff  or CONFIG_NUMA=3Dn cases.  Then could use either node_online(=
) or
> numa_map_to_online_node(), but I'm still curious as to how we would get a=
n
> offline NUMA node given how Hyper-V normally sets up a VM.
>=20
> NUMA nodes only transition from online to offline if there are no CPUs or
> memory assigned.  That can happen if the CPUs are taken offline (or never=
 came
> online) and if the memory is hot-removed.  We don't currently support hot=
-
> remove memory in Hyper-V VMs, though there has been some discussion about
> adding it.  I'm not sure how that case is supposed to be handled if the N=
UMA
> node is stashed in some device and get used during dma_alloc_coherent(), =
for
> example.  That seems to be a general Linux problem unless there's a mecha=
nism
> for handling it that I haven't noticed.
>=20
> Michael

