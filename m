Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027D1493155
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 00:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350248AbiARXUM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jan 2022 18:20:12 -0500
Received: from mail-co1nam11on2139.outbound.protection.outlook.com ([40.107.220.139]:4481
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237650AbiARXUL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jan 2022 18:20:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBxpx+52F+EiEoLchOrC415L7ogHWtjVcPcmE4TmkeolstlTmnZGlVtjIs3OdKhe+zocdoZf2OmgL4gyEStgMBPSTbS/uGPyR+EY1T8BShDype7c3VZadJzOJbB8Q4UP1CFycYK80WCjlsr+Nkw+Ed2pP0HOZw48g/ikJ20bfABuOzi97E6HBgHUfH9C5oTTt5/OcjWaKTawr718Vl7CAbi4QyBRxgU5CGJURz7JvLHgI/Iu+Qi41k+7aPGFo14q1T0nPblOUI6DOYvI03NqWivCkbPAJdCIQS3tAbphLdKEca2dHEACu0bsqoQnbTSTlpJ4wX/dcCvhChtegxqFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmCqsWFriJgsGQ970wXRMZerDolQ3FjAaUedr0HMPbk=;
 b=NBPidsZIrJjz2JhsFLUSYIEX6bS0xYzRRCB9OGcU7JTXmF/eEJxs5ozRtp91G0sSmQveoQvNcHtwVpQkxjMQ0u5wcOACR3UJtO7WNl35+S0AjW4PArvkYTZCYgByXY31WhecHBTwGgV1rrBU0kRph/tD926HUKWv3BQQ0CoIKCKdh17AIvu8Ic2yxtRGl1oH0m7SRtRuHLcEbvoOPv8szZzClZVaxcy4GWUQnwGR//rqAOvkWt1RHo+Hdyus3gUbz+/Vo0lpnNcgcpAu1/e8ZZCKkLeVRn4Fb7YXFthdrOHlfzXX+r2Wt6IXAW1mEYC75fH8S2JS1NGGVmjFu4t2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmCqsWFriJgsGQ970wXRMZerDolQ3FjAaUedr0HMPbk=;
 b=eUFTKva2y764IBU2EJFeZuGoXpHnuEJE2yZ4Ac3QS3WTWVQpaIEQIULvlNK12cSozzHz/roDMFPD2AQpXIwXH1SRp1KEsYJtslb5KMigWNUtDFSH1KbkA/V70dhlEh4yIs9MdIVBagIP88YMFqPe4UYzJry0/v7GXXDRtV0JpzM=
Received: from CH2PR21MB1509.namprd21.prod.outlook.com (2603:10b6:610:84::18)
 by MN2PR21MB1168.namprd21.prod.outlook.com (2603:10b6:208:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3; Tue, 18 Jan
 2022 23:20:07 +0000
Received: from CH2PR21MB1509.namprd21.prod.outlook.com
 ([fe80::e060:a16a:e925:8101]) by CH2PR21MB1509.namprd21.prod.outlook.com
 ([fe80::e060:a16a:e925:8101%5]) with mapi id 15.20.4909.001; Tue, 18 Jan 2022
 23:20:07 +0000
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
Thread-Index: AQHYA1QWLddhPIPNnk6mtn+/LlpFvqxXsWWAgABQoACABHENgIADtXxggAYN6oCAAzyJgIAABFMAgAAFyAA=
Date:   Tue, 18 Jan 2022 23:20:07 +0000
Message-ID: <CH2PR21MB1509F89BD3DB59E6396CFA24CE589@CH2PR21MB1509.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B0D34E7C42B9B0337136CE539@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593B3FF426AFF5B3F7C35E9D7569@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506829683984FD91061D907CE589@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593386F34FD34260FAE89EFD7589@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593386F34FD34260FAE89EFD7589@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6875b5f5-7f1e-4345-3f31-08d9dad910fd
x-ms-traffictypediagnostic: MN2PR21MB1168:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR21MB11689A1C0FB0E1DE9B4611B0CE589@MN2PR21MB1168.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EJvPVgeoAA4KpGm2/IKmJnKDclC8lzBjtnbN0PkkohR4978XQ3SBsomAnIdtURh3JOYi5THd84MEvUjsw1jlxz/4ECFzoX4Zsm6AOey6IbYf/9ZKaFQm65JFTaCNLvuoPVapae5ODz0l3jFQNlz99nQg0spnK0WQxjP+L4MOI1ycghOAzkyyRvf+HtXn3VISHlDBYQc7dS3HHOpo9lSHw4VLiMl1OWsxv6N+9l6rtn7Fu25852gYaCtnjJNfeMonu3L1YnO3izpkfndpPpKWFxqh3o/VUgRn3Abfh87aM/1E3HDgaU66i+ecp/hvQcfrVih7Di2zYj0Y0z4pn0wW9yL0nvb8HCPNToNzRC6SrW6dcnCc5wfweXRyrwjqeYeyRpjN77+NVV91NTLSZLHMLfXD/gi0jK6froQt0k0d8PoU2Wta7AloHmTLdYr8kstj8yZdHsgJWnS/lqRdU0QL2O4H6r9mKJ/9lFVVZljWlNvl3sucCyRSjiSceOvw1oR6bga6Ou2q3NaQIG/APQC3ShOOcRJ9Vt6fblmu4HgSWlIxocVFdtVML6qaJjUTLP2hFO+igxFs0PTHrqAk4ZHNfoTl9fBIeJVDAowdBcnYo/hD9UPDIZfztojDyBB0iZDGi0MdhtGzZA13OMZIUQW9ReEkkdYNKxrVgUq+KIdvsYi8hOj/vrE0c5kl6Ta8nzpUmZViVMHVaky94MdLB0PenXIvuV2N7tOTMve66K70FU0v5Tj23ZNsoYGCmLRzoFq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1509.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(9686003)(5660300002)(7696005)(82960400001)(76116006)(6506007)(110136005)(52536014)(38070700005)(33656002)(55016003)(82950400001)(6636002)(316002)(66556008)(66946007)(71200400001)(64756008)(66476007)(8990500004)(83380400001)(86362001)(66446008)(186003)(26005)(508600001)(2906002)(10290500003)(8936002)(8676002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9pM/YNG+GYLqQp+HBvz/mKCXLYAE1rn4WTj5ewu40vNNjwRHABrqr0XYwut5?=
 =?us-ascii?Q?pSY9SSMAc/Navf9JjqnNAc1Ln5rbAzQP/KHOIcLRPSuqSaoYERuuTabVeOd3?=
 =?us-ascii?Q?Mf63xZ7MlhAn8OhQ19dA+SDa3jDkcEAyp6guW/DQNGLvZQKu26ErD1A4oyNP?=
 =?us-ascii?Q?7MoKSxv0XJCZAp4qOFwwiEOxAmh2n1oqtJQRCI/OqhcdlOXDfc8HKIhA53FG?=
 =?us-ascii?Q?925eGCjRcCyv98G02fwxBJ9TiBdiXsb54WwYpH00O31gCrPlVwbTZEjLlJCZ?=
 =?us-ascii?Q?l9FRIrr5wXFTsEqV6SEg3OTTKNI+Lzojxo3n2iU0kLd6/oyvsOAQ3hQPDjQw?=
 =?us-ascii?Q?jSz4Db+LoWuQmwHWW3T2j7PMDIRuPYXaClJxMnB2RXHik6A9R40HuEUd3EBU?=
 =?us-ascii?Q?l6axE/2PakHV9ShCcQRgGblCuRz01t1Ip8xjC95FyjQXPWHJw0g4SeZB1PiM?=
 =?us-ascii?Q?kpqz85ihwOlSbSYssoTk2RYi7X0rmxAn6A7Enqse4x5Jh2M6l8qHQCwa7xIB?=
 =?us-ascii?Q?MKfPuMzht3+yS0E+AN63VZ6+SUXWlont54gUoW/uVuebjORKmuV1Gq8Mqnop?=
 =?us-ascii?Q?SxKolw+AGrm2TlidSVga9cuH4uRzbC+fCkJd6FuQCIekLq7BkdlvOZ18oLTM?=
 =?us-ascii?Q?B6fN3Qg9Kun60yKHsM7niwsLwAG/0p5iqpEKUQ86N0UGPGruHVfPBINdJfGt?=
 =?us-ascii?Q?1Fl4F7Kjfp/r+GvKxNl3c2FQCwZzjaKAAD2NS3eTCPqGgvBBF6fPVitpJ8X5?=
 =?us-ascii?Q?eaXya0G9rDS6f8scjkRJcryRL3Pnku+67nF0dq/cDZ0OeyWKU08FcHizI5F5?=
 =?us-ascii?Q?Yo9OjdVDgKkt2FWrLIWWFgYQBDXWeeAtmXFdwBZGwI4mRSZRdu9YvVPFFAgO?=
 =?us-ascii?Q?vb0HdHJI0Lt3jR3fCmCDyKUm9bAGteR7YukjbuGwvfRxWsfYzxd0sq39ZT92?=
 =?us-ascii?Q?DZtUbqslx+5ZUhn7W02/gCHduVjkzIpKKeSeSnHzX9sJuB8+AiW2rYgUsNeV?=
 =?us-ascii?Q?KJxDh4XOitGT4FDuXHlMEOiFPBaz4FeCQLGCDmTeCRIuooyiE5Jqp7DHMa55?=
 =?us-ascii?Q?7vhFUiDqM/lO8pVbTC4II6XMjxgW4fPnNuVvpVkuJ+99A9GB1/r0xb2gIncA?=
 =?us-ascii?Q?oWlHYbXO7uhgO1oYH7XLJ6c/7xYuSAsR2u6d9Htse72fyokTvDkXwBxWfJEn?=
 =?us-ascii?Q?GCMdhhMmNeS8bYoflUUpBuZUrX/Fr6cwPA0+1Vr2DeW8A5h7alWLLPo9gYIV?=
 =?us-ascii?Q?6ye1Z8ALP07nZOgcUT9B+XQGAAbVowEQda21rOxPyrLISdJfkKCLbtL4S2GY?=
 =?us-ascii?Q?V7J8g/nZCtTxhuFxN12/ZXRZs8EbnXWSCBQUgmHmktJDxm46KpJdKv9pk/07?=
 =?us-ascii?Q?p+9Hmrz7nMDP9svxmPTclA9qJwYqVp59+xQY0af0yv54A2d0fZb1Nd6hmI0Z?=
 =?us-ascii?Q?7eoeJH20LjE/EZY6BN64dBL/aloslIyQizXeAqt07wipatLhXprdgqkqmzfb?=
 =?us-ascii?Q?GsDj3uzIjYsYuxans+d4OYtrM/f1nx6R8dGfEfEYTSs+44oAs9A5HEGJPLdz?=
 =?us-ascii?Q?dbHPK9laOV0AOwJKXk3khRotHizy4525aiMdRoa55S02FBj/o4dh+n40M5ib?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1509.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6875b5f5-7f1e-4345-3f31-08d9dad910fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 23:20:07.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewZk00CxCzZHk9LI61AhTeX8Yhjdz6H6qh9hx2cmuk2iPtvwcv6m0oeQ1CLL0ixBNyBf6Q4WW8EKCKXGz3vtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1168
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots
> with parameters affecting NUMA topology
>=20
> From: Long Li <longli@microsoft.com> Sent: Tuesday, January 18, 2022 2:44=
 PM
> > >
> > > From: Long Li <longli@microsoft.com> Sent: Wednesday, January 12,
> > > 2022 4:59 PM
> > > >
> > > > > Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when
> > > > > kernel boots with parameters affecting NUMA topology
> > > > >
> > > > > From: Long Li <longli@microsoft.com> Sent: Friday, January 7,
> > > > > 2022
> > > > > 12:32 PM
> > > > > > >
> > > > > > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sen=
t:
> > > > > > > Thursday, January 6, 2022 3:20 PM
> > > > > > > >
> > > > > > > > When the kernel boots with parameters restricting the
> > > > > > > > number of cpus or NUMA nodes, e.g. maxcpus=3DX or numa=3Dof=
f,
> > > > > > > > the vPCI driver should only set to the NUMA node to a
> > > > > > > > value that is valid in the
> > > current running kernel.
> > > > > > > >
> > > > > > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > > > > > ---
> > > > > > > >  drivers/pci/controller/pci-hyperv.c | 17
> > > > > > > > +++++++++++++++--
> > > > > > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > > > > > b/drivers/pci/controller/pci- hyperv.c index
> > > > > > > > fc1a29acadbb..8686343eff4c 100644
> > > > > > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > > > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > > > > > @@ -1835,8 +1835,21 @@ static void
> > > > > > > > hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> > > > > > > >  		if (!hv_dev)
> > > > > > > >  			continue;
> > > > > > > >
> > > > > > > > -		if (hv_dev->desc.flags &
> > > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > > > > > > -			set_dev_node(&dev->dev, hv_dev-
> > > >desc.virtual_numa_node);
> > > > > > > > +		if (hv_dev->desc.flags &
> > > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > > > > > > > +			int cpu;
> > > > > > > > +			bool found_node =3D false;
> > > > > > > > +
> > > > > > > > +			for_each_possible_cpu(cpu)
> > > > > > > > +				if (cpu_to_node(cpu) =3D=3D
> > > > > > > > +				    hv_dev->desc.virtual_numa_node) {
> > > > > > > > +					found_node =3D true;
> > > > > > > > +					break;
> > > > > > > > +				}
> > > > > > > > +
> > > > > > > > +			if (found_node)
> > > > > > > > +				set_dev_node(&dev->dev,
> > > > > > > > +					     hv_dev-
> > > >desc.virtual_numa_node);
> > > > > > > > +		}
> > > > > > >
> > > > > > > I'm wondering about this approach vs. just comparing against
> > > nr_node_ids.
> > > > > >
> > > > > > I was trying to fix this by comparing with nr_node_ids. This
> > > > > > worked for numa=3Doff, but it didn't work with maxcpus=3DX.
> > > > > >
> > > > > > maxcpus=3DX is commonly used in kdump kernels. In this config,
> > > > > > the memory system is initialized in a way that only the NUMA
> > > > > > nodes within maxcpus are setup and can be used by the drivers.
> > > > >
> > > > > In looking at a 5.16 kernel running in a Hyper-V VM on two NUMA
> > > > > nodes, the number of NUMA nodes configured in the kernel is not
> > > > > affected by maxcpus=3D on the kernel boot line.  This VM has 48
> > > > > vCPUs and 2 NUMA nodes, and is Generation 2.  Even with
> > > > > maxcpus=3D4 or maxcpus=3D1, these lines are output during
> > > > > boot:
> > > > >
> > > > > [    0.238953] NODE_DATA(0) allocated [mem 0x7edffd5000-0x7edffff=
fff]
> > > > > [    0.241397] NODE_DATA(1) allocated [mem 0xfcdffd4000-0xfcdfffe=
fff]
> > > > >
> > > > > and
> > > > >
> > > > > [    0.280039] Initmem setup node 0 [mem 0x0000000000001000-
> > > 0x0000007edfffffff]
> > > > > [    0.282869] Initmem setup node 1 [mem 0x0000007ee0000000-
> > > 0x000000fcdfffffff]
> > > > >
> > > > > It's perfectly legit to have a NUMA node with memory but no CPUs.
> > > > > The memory assigned to the NUMA node is determined by the ACPI SR=
AT.
> > > > > So I'm wondering what is causing the kdump issue you see.  Or
> > > > > maybe the behavior of older kernels is different.
> > > >
> > > > Sorry, it turns out I had a typo. It's nr_cpus=3D1 (not maxcpus).
> > > > But I'm not sure if that matters as the descriptions on these two
> > > > in the kernel doc
> > > are the same.
> > > >
> > > > On my system (4 NUMA nodes) with kdump boot line:  (maybe if you
> > > > try a VM with 4 NUMA nodes, you can see the problem)
> > > > [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.11.0-1025=
-
> azure
> > > > root=3DPARTUUID=3D7145c36d-e182-43b6-a37e-0b6d18fef8fe ro console=
=3Dtty1
> > > > console=3DttyS0
> > > > earlyprintk=3DttyS0 reset_devices
> > > > systemd.unit=3Dkdump-tools-dump.service
> > > > nr_cpus=3D1 irqpoll nousb ata_piix.prefer_ms_hyperv=3D0
> > > > elfcorehdr=3D4038049140K
> > > >
> > > > I see the following:
> > > > [    0.408246] NODE_DATA(0) allocated [mem 0x2cfd6000-0x2cffffff]
> > > > [    0.410454] NODE_DATA(3) allocated [mem 0x3c2bef32000-
> 0x3c2bef5bfff]
> > > > [    0.413031] Zone ranges:
> > > > [    0.414117]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
> > > > [    0.416522]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
> > > > [    0.418932]   Normal   [mem 0x0000000100000000-0x000003c2bef5cff=
f]
> > > > [    0.421357]   Device   empty
> > > > [    0.422454] Movable zone start for each node
> > > > [    0.424109] Early memory node ranges
> > > > [    0.425541]   node   0: [mem 0x0000000000001000-0x000000000009ff=
ff]
> > > > [    0.428050]   node   0: [mem 0x000000001d000000-0x000000002cffff=
ff]
> > > > [    0.430547]   node   3: [mem 0x000003c27f000000-0x000003c2bef5cf=
ff]
> > > > [    0.432963] Initmem setup node 0 [mem 0x0000000000001000-
> > > 0x000000002cffffff]
> > > > [    0.435695] Initmem setup node 3 [mem 0x000003c27f000000-
> > > 0x000003c2bef5cfff]
> > > > [    0.438446] On node 0, zone DMA: 1 pages in unavailable ranges
> > > > [    0.439377] On node 0, zone DMA32: 53088 pages in unavailable ra=
nges
> > > > [    0.452784] On node 3, zone Normal: 40960 pages in unavailable r=
anges
> > > > [    0.455221] On node 3, zone Normal: 4259 pages in unavailable ra=
nges
> > > >
> > > > It's unclear to me why node 1 and 2 are missing. But I don't think
> > > > it's a Hyper-V problem since it's only affected by setting nr_cpus
> > > > over kernel boot line. Later, a device driver
> > > > (mlx5 in this example) tries to allocate memory on node 1 and fails=
:
> > > >
> > >
> > > To summarize some offline conversation, we've figured out that the
> "missing"
> > > NUMA nodes are not due to setting maxcpus=3D1 or nr_cpus=3D1.  Settin=
g
> > > the cpu count doesn't affect any of this.
> > >
> > > Instead, Linux is modifying the memory map prior to starting the
> > > kdump kernel so that most of the memory is not touched and is
> > > preserved to be dumped, which is the whole point of kdump.   This
> > > modified memory map has no memory in NUMA nodes 1 and 2, so it is
> > > correct to just see nodes 0 and 3 as online.
> > >
> > > I think code fix here is pretty simple:
> > >
> > > 	int node;
> > >
> > > 	node =3D hv_dev->desc.virtual_numa_node;
> > > 	if ((hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > 			&& (node < nr_node_ids))
> > > 		set_dev_node(&dev->dev, numa_map_to_online_node(node));
> > >
> > > Michael
> >
> > Okay, this looks good.
> >
> > I'm sending a V2 (with a minor change) after testing is done.
> >
> > Long
>=20
> Please leave a comment in the code as to why a NUMA node might be
> offline.   In the future, somebody new might not know what can happen.
> I certainly didn't. :-(

Will do that.

Long
