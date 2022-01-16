Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C774D48FF0C
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Jan 2022 22:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiAPVSO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 16 Jan 2022 16:18:14 -0500
Received: from mail-eus2azon11021026.outbound.protection.outlook.com ([52.101.57.26]:28899
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233648AbiAPVSO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 16 Jan 2022 16:18:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDPu8fA52FSowImA88qGKRHpzpdsAZC5w62zAix+PP4KVofQvp2xCEUEM6eY97j6deKOrXUvClFSdZCzqSojByYwzFOZffHsGTJUKTwVbeKmCfJ/rXmifjy6ymtzmbe03LWrD0rAcLovAsio5iFBG9hzcDGB0aeyWjO+YnAwW/X6e9B10bA4Im2C7FPNXbyC69kGQ6Q8kgp+Z4DDjHUFaSH7EdlYN2MMtiWViBaOYAnIG6Zpdi2PzzqE2FEc10JQo2Be0Q3q2808MnN0hQaNvPAJblFCedqZAW9E1lrXtpjMywbwCqKCEgjyvrgC1SyaF1LLkWXhW0rEz1aB2WSSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dFgrbSaK+Y5GeV/ozNZ25oVWpXHdDzZ9WUhSX5DGSs=;
 b=Xa7Z8WzMMsWqhYzId1JD14zSF85lKSm+pmPlSpbKxEDNmFsjKJ/xfjloJQ4daUQN7n9YV6zmdlqwIpIxDlnT3I1q4uD39aYPBiu6g371AGtnyV07bjfhFpnmR8hvyKZUmhNRLi5tQGd/9phtI4zlgjLFlBU3PS62I9KrCGXMGT0RNb4k0PgYxXKA8VY8O1u8NRhFvo4UWMpm1NUQOg8Yk8FBBDrX75Tg/QOOTab5wFFZChAK+nzDhfpUiDucgMIOMbtsoxATxD3ARAbZr1HLRTfVHY+a7uBKekK665GZjLo67sbJvWltz/Ko6/pEeHgw11PF01W8CHIj4BAdgnuV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dFgrbSaK+Y5GeV/ozNZ25oVWpXHdDzZ9WUhSX5DGSs=;
 b=Cc7w7mFinEVQ9Zm1fGN9VET/7K9ClfEUE9srhzVnJ44pwFhnEcZ6ztGqbadxSUdlkmD9aEhkG2rb2dbICES1ORw+cX0HdcQCSMFTQ+2RFmICrc+XlpoV8sZr46k3zdyoA8/iMFelyB4SpNWTEYfccLVxajtRxKtL5yJgsenUMAs=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0190.namprd21.prod.outlook.com (2603:10b6:300:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.2; Sun, 16 Jan
 2022 21:18:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::7478:bb68:bc94:3312]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::7478:bb68:bc94:3312%3]) with mapi id 15.20.4909.004; Sun, 16 Jan 2022
 21:18:11 +0000
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
Thread-Index: AQHYA1QWURfWxy//0UuSygYpK/bNEqxXrRcQgABXZwCABGe4cIADvrGAgAYErcA=
Date:   Sun, 16 Jan 2022 21:18:11 +0000
Message-ID: <MWHPR21MB1593B3FF426AFF5B3F7C35E9D7569@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B0D34E7C42B9B0337136CE539@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506B0D34E7C42B9B0337136CE539@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c11815-023f-4ea7-220b-08d9d935b33f
x-ms-traffictypediagnostic: MWHPR21MB0190:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MWHPR21MB019065D17AEBB532C671A67ED7569@MWHPR21MB0190.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XStte4yHETgHKB/SuP4lthKtKG1HlXOXSBZvw644USjV7tnwfnwTWN/sFvbpi200hKiJkLIk2hFjDHSv4Hyf6aGYtia6GuVAzY/EusB8KYKqcLc7d5t7RM9sTC06SG/Hf97gVt2qZXhbk5DqDzUNyZH5nZnClwz9EkYb3frXWkV/qZ0brhI/Grt72XdgLq63hhLaUkPIc3thfRm9RFzH8x0PTLxNbEmiHIRZG9AhfToMnKXImEl/jYue8lXSsEq36Rqday/JZ4oOPyjs+erzrxvvkzHFg63pgW4aeKbarSKu8Sf0MYQeF3knMIOlPopbVXk8JOHUav04R+IJhpawqnn7HDy8ZZ+xkzWcKGdBQR1OYKucf+Lx6ww+pTdBnQ1rFPP3eUcHWzGIOrvh0R6Xp0A+fsXSdvK2Kf7ogZyPU2q9tJe7rPA8mawoVTKHhwtIcPbtnVEP3IEVDQ9bq7um10u4jDL8A7LS7ldzzUgFK8Rsyjeinp520qNsH9iA+l8JjlsxgJEePjMw0SgcUR6u1h3LuRDQlCutcii5si8C3m64MlgGQYFYMMIFdujZcOCVEuFO1MfZWnzVpcL2K10RyCCbXcSnHgwwy1/B6uNBRwELI4OyllS8+xVR6gl4MaKQmogrTmHanEuzGkYTj3edO/mm/n5HD0ojBUTfGBmrb9Sia1rKu3WLJyGhPzfEJtJx3jZlpO1gxOXajoDMGVBI9LubePqR++ytBiKRzyYuNGSxYvKewofvUJgBVrUeGLCO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(8990500004)(8676002)(8936002)(66446008)(66476007)(2906002)(52536014)(66556008)(64756008)(33656002)(66946007)(53546011)(7696005)(86362001)(55016003)(6506007)(9686003)(5660300002)(83380400001)(10290500003)(71200400001)(508600001)(82960400001)(38100700002)(82950400001)(110136005)(76116006)(316002)(6636002)(38070700005)(122000001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JIrdoIQ79pxi9Jnh5tCmxAmXpBqZCcfxV4LMmqricSaLkrmWOZh2GO/sa2ST?=
 =?us-ascii?Q?UeePUOIEiqwF51fQwp0A79mwQDZadc0N6Dhj7Vat6+OqlkL68dBeGb6oltnb?=
 =?us-ascii?Q?uC7pKk/4JIbxSZ1l8jlekqbKsAPJ64xwA2+RxVS5Y63Ajfw1srv2aGgy/jvI?=
 =?us-ascii?Q?4castnTEDye9a4kyQKQwBN/A6FZvEw0MnE64Oqv9Mi6ApcpB3NfxjnRW8cYe?=
 =?us-ascii?Q?p8zPDpKkL+y4zfWo7A7sWJ1c7kbyNb1x9FFQX/0fbURqkIWY1SvXyVAOFVKy?=
 =?us-ascii?Q?yVNecW2Tg4GgBC9FhX8iSrhKUZ8azghbGrIS+FO31/EpTfRYsbzAxTuD/u/0?=
 =?us-ascii?Q?p7ROqHW8XQQVsxwAalEFgLQnN+gMgmcTQE9QCYxC3PaHsa59Ez6sfVTqslEm?=
 =?us-ascii?Q?TS+rBSRgxsIZ+us5F3k4WemRwyZhOXoLxJp7MFieh62t2nW70OGb+z78Zlen?=
 =?us-ascii?Q?bhergqwmK8nnvsnIs0t+28sMVdF7aktvlLH+q3AkdNdnWRFQMe8PBwWC6ifr?=
 =?us-ascii?Q?NW8RxyHr3PDRn72GtwFBEDgdkD1jNa5a4LvxB0zaEE2LKUcx0aLso8rpH8ju?=
 =?us-ascii?Q?ZwoDgqiPVXTHIp0jb0YuM7oIgNDIDh0jPHQdPITo4fNx+/GNP4pNkl0knvat?=
 =?us-ascii?Q?qSaUfRmWqc/dAQVTuzu6Y2iglICKrYDMMaBaUj1EuW8UADkbDzsVMalpKAu4?=
 =?us-ascii?Q?6pn28FGouJbZbC99oD9tQR1E6Y6m2wdT9vHcWtpb6UNrIKlu92HfrrZqGyv6?=
 =?us-ascii?Q?428F70m8ufKSMwszqSA/0Jjqos52OobCa3lKjh1RIJ4SgEDuuXN5M2zXriPR?=
 =?us-ascii?Q?QcZ/v9mgi7wcqJyLFvyXkJecp4xzg2NL9budyUM3sfPlFPPR72dxwo7TaxQM?=
 =?us-ascii?Q?EwXTTAQ3ICJgKMoDjp5IGcLWCwRyixuRv3qrjx0wXFU13X0OJr3YNRvmgcUO?=
 =?us-ascii?Q?WbBu1VJG2QPaU7IaI6FYIDh+4Y42J8MrVaBNdqQ3hFSG3HgiNTIAvEtg4dbp?=
 =?us-ascii?Q?n65aJaLXpR0hILjh4N7x/cpNGTGYiYxiMCCmYm0i9AEJ7l1p6+CXzDyT5zBg?=
 =?us-ascii?Q?uZeckG5rRItlK1FQyHnKKPXZfi1Fi+A+TB46n6COkoJVFszyHAqBaBoytTFD?=
 =?us-ascii?Q?EjVxVFKN8+ieViTCgbTiqhgg7Wj8rQODxWcPbaIJ3c0Gr9eQ01E8IjIg59iO?=
 =?us-ascii?Q?MvecbAROXNPIUGMiYNlwiX6/bocmgd+HV4wpaZB/yp4pRHLzZR/CvMrGrMxj?=
 =?us-ascii?Q?mLWw5OnX3GDIKpL5NBReUvpg1nKyQ/OEcXIAIdX2Na5tcxVR1ptNZVztmLrA?=
 =?us-ascii?Q?UMS933j4R+bRHC7nyEy84NpVP93FCi+j4w3ktfYD+AvxSylCTiJWxfp1yRRT?=
 =?us-ascii?Q?ymfsJUEuzMSK2/W1YQSoT8DzSGLzlOZUVXLZlvtNGILcAGJg1uetL4ShdJ21?=
 =?us-ascii?Q?pLa85oOUUvttjbYKPu0l8F/3Nn1hwtyZgAtXxv2iOBuPV5xkXebNPyqKPJN8?=
 =?us-ascii?Q?cZ3HuFN4bUJWvhzqpiHO5TEKJ+oSSMcizpHdXe0aOjaO7Jw7qg4WCbOBi6CU?=
 =?us-ascii?Q?Jv1bDAByYKEi4tFD9kUgQJJFiCm5Gcg94wHndulFLBr6c0Qqx9yEYTIkNGmR?=
 =?us-ascii?Q?g0AOSzRVn8kxjZaxRAYC82IR1XaEuLTjSCSYuTLjmeUcBbaUtvxg8wts7fKv?=
 =?us-ascii?Q?76UE4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c11815-023f-4ea7-220b-08d9d935b33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2022 21:18:11.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgOKsL+0XmYJxRLHHBtt32tz5Zdy/nCuC1xZMQonrPQR+IlkvYHw9FBPQBDVPEt3e03TwHsGUtY4cJG8fYqLvTBl2qijO3UHQZ4KTskyJF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0190
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Wednesday, January 12, 2022 4:59=
 PM
>
> > Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boot=
s
> > with parameters affecting NUMA topology
> >
> > From: Long Li <longli@microsoft.com> Sent: Friday, January 7, 2022 12:3=
2 PM
> > > >
> > > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> > > > Thursday, January 6, 2022 3:20 PM
> > > > >
> > > > > When the kernel boots with parameters restricting the number of
> > > > > cpus or NUMA nodes, e.g. maxcpus=3DX or numa=3Doff, the vPCI driv=
er
> > > > > should only set to the NUMA node to a value that is valid in the =
current running kernel.
> > > > >
> > > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > > ---
> > > > >  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
> > > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > > b/drivers/pci/controller/pci- hyperv.c index
> > > > > fc1a29acadbb..8686343eff4c 100644
> > > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > > @@ -1835,8 +1835,21 @@ static void hv_pci_assign_numa_node(struct
> > > > > hv_pcibus_device *hbus)
> > > > >  		if (!hv_dev)
> > > > >  			continue;
> > > > >
> > > > > -		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > > > -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> > > > > +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > > > > +			int cpu;
> > > > > +			bool found_node =3D false;
> > > > > +
> > > > > +			for_each_possible_cpu(cpu)
> > > > > +				if (cpu_to_node(cpu) =3D=3D
> > > > > +				    hv_dev->desc.virtual_numa_node) {
> > > > > +					found_node =3D true;
> > > > > +					break;
> > > > > +				}
> > > > > +
> > > > > +			if (found_node)
> > > > > +				set_dev_node(&dev->dev,
> > > > > +					     hv_dev->desc.virtual_numa_node);
> > > > > +		}
> > > >
> > > > I'm wondering about this approach vs. just comparing against nr_nod=
e_ids.
> > >
> > > I was trying to fix this by comparing with nr_node_ids. This worked
> > > for numa=3Doff, but it didn't work with maxcpus=3DX.
> > >
> > > maxcpus=3DX is commonly used in kdump kernels. In this config,  the
> > > memory system is initialized in a way that only the NUMA nodes within
> > > maxcpus are setup and can be used by the drivers.
> >
> > In looking at a 5.16 kernel running in a Hyper-V VM on two NUMA nodes, =
the
> > number of NUMA nodes configured in the kernel is not affected by maxcpu=
s=3D on
> > the kernel boot line.  This VM has 48 vCPUs and 2 NUMA nodes, and is
> > Generation 2.  Even with maxcpus=3D4 or maxcpus=3D1, these lines are ou=
tput during
> > boot:
> >
> > [    0.238953] NODE_DATA(0) allocated [mem 0x7edffd5000-0x7edfffffff]
> > [    0.241397] NODE_DATA(1) allocated [mem 0xfcdffd4000-0xfcdfffefff]
> >
> > and
> >
> > [    0.280039] Initmem setup node 0 [mem 0x0000000000001000-0x0000007ed=
fffffff]
> > [    0.282869] Initmem setup node 1 [mem 0x0000007ee0000000-0x000000fcd=
fffffff]
> >
> > It's perfectly legit to have a NUMA node with memory but no CPUs.  The
> > memory assigned to the NUMA node is determined by the ACPI SRAT.  So I'=
m
> > wondering what is causing the kdump issue you see.  Or maybe the behavi=
or of
> > older kernels is different.
>=20
> Sorry, it turns out I had a typo. It's nr_cpus=3D1 (not maxcpus). But I'm=
 not sure if that
> matters as the descriptions on these two in the kernel doc are the same.
>=20
> On my system (4 NUMA nodes) with kdump boot line:  (maybe if you try a VM=
 with 4
> NUMA nodes, you can see the problem)
> [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.11.0-1025-azure
> root=3DPARTUUID=3D7145c36d-e182-43b6-a37e-0b6d18fef8fe ro console=3Dtty1 =
console=3DttyS0
> earlyprintk=3DttyS0 reset_devices systemd.unit=3Dkdump-tools-dump.service=
 nr_cpus=3D1
> irqpoll nousb ata_piix.prefer_ms_hyperv=3D0 elfcorehdr=3D4038049140K
>=20
> I see the following:
> [    0.408246] NODE_DATA(0) allocated [mem 0x2cfd6000-0x2cffffff]
> [    0.410454] NODE_DATA(3) allocated [mem 0x3c2bef32000-0x3c2bef5bfff]
> [    0.413031] Zone ranges:
> [    0.414117]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.416522]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.418932]   Normal   [mem 0x0000000100000000-0x000003c2bef5cfff]
> [    0.421357]   Device   empty
> [    0.422454] Movable zone start for each node
> [    0.424109] Early memory node ranges
> [    0.425541]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.428050]   node   0: [mem 0x000000001d000000-0x000000002cffffff]
> [    0.430547]   node   3: [mem 0x000003c27f000000-0x000003c2bef5cfff]
> [    0.432963] Initmem setup node 0 [mem 0x0000000000001000-0x000000002cf=
fffff]
> [    0.435695] Initmem setup node 3 [mem 0x000003c27f000000-0x000003c2bef=
5cfff]
> [    0.438446] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.439377] On node 0, zone DMA32: 53088 pages in unavailable ranges
> [    0.452784] On node 3, zone Normal: 40960 pages in unavailable ranges
> [    0.455221] On node 3, zone Normal: 4259 pages in unavailable ranges
>=20
> It's unclear to me why node 1 and 2 are missing. But I don't think it's a=
 Hyper-V problem
> since it's only affected by setting nr_cpus over kernel boot line. Later,=
 a device driver
> (mlx5 in this example) tries to allocate memory on node 1 and fails:
>=20

To summarize some offline conversation, we've figured out that
the "missing" NUMA nodes are not due to setting maxcpus=3D1 or
nr_cpus=3D1.  Setting the cpu count doesn't affect any of this.

Instead, Linux is modifying the memory map prior to starting the
kdump kernel so that most of the memory is not touched and is
preserved to be dumped, which is the whole point of kdump.   This
modified memory map has no memory in NUMA nodes 1 and 2, so
it is correct to just see nodes 0 and 3 as online.

I think code fix here is pretty simple:

	int node;

	node =3D hv_dev->desc.virtual_numa_node;
	if ((hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
			&& (node < nr_node_ids))
		set_dev_node(&dev->dev, numa_map_to_online_node(node));

Michael
