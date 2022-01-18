Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7474930F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jan 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiARWoS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jan 2022 17:44:18 -0500
Received: from mail-eus2azon11020020.outbound.protection.outlook.com ([52.101.56.20]:19135
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237704AbiARWoR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jan 2022 17:44:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJQcfgRYaBQe5/GXpftrVNF26BggkD0yYwJtg92jgdnRl3G49jmV+KTUpmYCIbT1BbyMwIHyzZgRWZ2MOchfp1v72jyUMCM4Q9IHfCdwUGs7nY8if4GuDoLThFKdp0iTxqYcn2mpXZ9SIgGWWckgolgiZgWWBfKCqf45vM5Eg1jzfRny/dKZOKt5hJUqDiF01SfWZg7mL6lE7PumCjWGn/GLAtihJr2T+ONZA45yjZLW+6auyyjU9kOcLdPPpAW8xRF/m7W8Q/zUjMW3ChDx2U7rvh8TvVThtBQ+FCcI97OWbD6cOuP/9vMZ8W57hJnZQztLNN3JthNuOCUQWncpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsxQDf1zpqTWD5gxK7Qr1FMS+YUWax60/X/d/hisl9A=;
 b=AZV25Y3CL3Ml4zPjY987iLN7GMc+Bpg0D2Hm0JGG1jMo0gXF6GVejXntpPH9h3fBdho2qSPaEcBvkIn6aXhliSdCBIDO+xZGLj91mGVE59uh29U/leEH5Vg1uxlSUDcpK9bPNLjuZfg5m12j+xOYKJUwSlrMgBk0r10fuDySkOAHNwek89GZL1IR7cC++6iKiSwB36tpGHBOkfoCKwBVHGG6Gusz2OObDe5MXYMzR9jVDs6FJM6rQNJodx2/uylWxdjlmslPr5Ib6Vs+zz1YfJ7thCG13fvubImyQxN29jxRvon6zR3q0RNtDHHo7rLnnRFaL/LoLGkLj7vg7NZSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxQDf1zpqTWD5gxK7Qr1FMS+YUWax60/X/d/hisl9A=;
 b=gv0TMKm1FJEgn9gRaibxanndY+sTfmi9jLoHlXk5BUNQQpyHyoX8IRti+Zm+cRcBXMOuRePPEowtWAM0Vmj+QxxqHm++gSiDcmhycRwYNyi+nV9wzWyLCAGkOVvcOjEjBFoyDo1ccqF2CwYvc7zoc6guqEnITTPUH7WHfJurWgM=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by MW2PR2101MB0923.namprd21.prod.outlook.com (2603:10b6:302:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3; Tue, 18 Jan
 2022 22:44:12 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d18c:f0b3:8491:22e1]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d18c:f0b3:8491:22e1%3]) with mapi id 15.20.4930.003; Tue, 18 Jan 2022
 22:44:12 +0000
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
Thread-Index: AQHYA1QWLddhPIPNnk6mtn+/LlpFvqxXsWWAgABQoACABHENgIADtXxggAYN6oCAAzyJgA==
Date:   Tue, 18 Jan 2022 22:44:12 +0000
Message-ID: <BY5PR21MB1506829683984FD91061D907CE589@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B0D34E7C42B9B0337136CE539@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593B3FF426AFF5B3F7C35E9D7569@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593B3FF426AFF5B3F7C35E9D7569@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d50f50f5-87e4-4a38-9143-08d9dad40c9d
x-ms-traffictypediagnostic: MW2PR2101MB0923:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB0923EA3DBBBC649E1B6419AACE589@MW2PR2101MB0923.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPCu2Nf7DJXkwezLdCtm5IsqKycj658lLp8J+s/CNasnYa7fo1p0Mzh6qRgX5ww/x3n/73nZ5Vz+/9SzQGGDi59pYuZOeu7Tb7j7jez+qMONl6WF6ORUdAHzUM22ilNY1Tdc8ydXiCreXV8J2I2Hbu/7q5Udl4WKuVb/rhTdpTDkyzM1KTGnYNcRNEfqmf2aiQVNlSjl+4iPm3Wqeia3OmrEJlc6UIxZgF9yEaZAST/nd6MU2JfbWWGFrzB/8+q45KqVU3u9S8PUP4u0f35xosLZs8MZcIVOLzK9wJ6mRtzO/awp9Eune+EHOC3aQwdXZWQt3e3Jqd9IfqbJYTcGnz1+P9/91zyWuPNifHwfaP4OdYtCLcjmlSn31eHodH5y6bjJOnRBF6WbMQ3gEUzZj1v5GjG1pcPlSqD0e5zWU5+jfwXg2Rkxg1d8tRKagJ0kWXJCcB/rtnrwQViVWfjp1ksYI47NYytOrgxBttkQav8jiPxy1HId6rMFsjPQVDz2DwIwbAhgjt2NfiewBJ/5vdgFn36NumK7JAlGzxDDmBBYvsKWeTtoFzWqPG5QGFWcbPWzwvdAqFYJhtmbuXTOIPnnjiw/KOiZvHePLaQ1FbHKo4AG8dRCGpR1fG9gLdtKdWKUd4tR6FCkgC1ORfqkiE0h+r06n3I2FRmN1rNvsr4Agy11uMIHC5jSgBxGdkvB7Fsn9AIw4YALLZLkzGDJY3YMbChkgpiuUzsoLByvtnMCRAtYB8FRkh/fdDPiGZ7H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(508600001)(71200400001)(6506007)(10290500003)(38070700005)(38100700002)(122000001)(82960400001)(82950400001)(7696005)(86362001)(186003)(26005)(83380400001)(66556008)(64756008)(66476007)(52536014)(66446008)(76116006)(33656002)(8990500004)(316002)(66946007)(6636002)(110136005)(8676002)(8936002)(5660300002)(55016003)(2906002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q2o2eJgpxXkVt2w/Kl1w4XqQO0u6OC2Uem1QAjp9bJILT0xgrlcaW3CxZTKj?=
 =?us-ascii?Q?oiBkiFtM45FahDjhM/FFg1yjP3lrxTJHxQC8VG4vUiE0+5Grtp9OC4WBa2TB?=
 =?us-ascii?Q?QDcucakWiqWYYBD0iP7jO+nIlhgJDeb+uTfulqwLd/SIaIZR/LWbF8ji2UbQ?=
 =?us-ascii?Q?J5GIs7Qr+BJyRU8CVyBzd8G7onmFBuG3q4yWkmYYcHKccItACdKGd9FDO9tR?=
 =?us-ascii?Q?yhAmwGkbcuvGPOb9gnvhFGh88Ie63s+31TjtashB8sL3ZlB9zrCjZ+hsF1wE?=
 =?us-ascii?Q?qVQPhKWu/W+m4VLX/AJHGxN+4WLZ0NOnwTLPFIwJJXzdeBMCQSfTLd3iX3A0?=
 =?us-ascii?Q?Dd4Jrbf3GvnIwRS3qstZ2ls3LW6Iyntv/4NyMqSCXpzuNId4hUE5N8Zt0LJE?=
 =?us-ascii?Q?0nkvxeG3sywI09ScJQbOGOFkmspNEhyoQFv2v6ORbdL/EmhQlguZIbBAL0VA?=
 =?us-ascii?Q?k3WwukLSYSXpYHSMENXRHKsJA1QI1yiuYGu6sCYMSA0urDX5huPdhhxYJyfC?=
 =?us-ascii?Q?svHT+34BGuWm3i2ExPwxyXxyyIUFKlEPXA9QT8atbG5xWbOsW79ano6xf5v3?=
 =?us-ascii?Q?JGO/1HByqpdjQBrqHSUWUj3wmDpt+PXgm4OrotzVl1VXixbeexWLp7GgQ9LV?=
 =?us-ascii?Q?SpcyVns4Wc9cugstcUJd0pTwapuFcTXimQhyYW7xIfUqR4e7lvGJIRzH1IOa?=
 =?us-ascii?Q?hxx3uHFNUyVDoyswJITGsRoPA3n9+/mpjKYU3NX5/QZx4zcA+w0LCMl8t4vy?=
 =?us-ascii?Q?L2v92X5vDnuOtgzrTStVmueezJooupLgAn8atfrC42/dPv57jJm3AairWeqh?=
 =?us-ascii?Q?V/QzFAZPQg8MFCQ5oeRxPFZqQZGGgdJV99btmBSNvrGwGIZ0VSHr8GcumD+J?=
 =?us-ascii?Q?S89L2e/nmnmcowAlp+aKmfKyM1aziBYpIJT0zrWumGtwS+LI9rJaxVsTT/oM?=
 =?us-ascii?Q?50oauP01uuiY1vAAomtHZFT9eCwsYD7jtPeo2w7KjNwx2tu2s5jqa4YkpT1T?=
 =?us-ascii?Q?4tsgkrUFwQ0O6r9//GexhYb2CSyMKOAKlLngz31fucnuKHIWRqEKtysXoSLy?=
 =?us-ascii?Q?h4jG2fykxsZhVDqUsO8f2O6k4dA5924XQKNZfmdSOFzKY+YfD7D7k7BU3NSs?=
 =?us-ascii?Q?ZUaYOsB+/W++C5EMqNPSUYwR0q8x6byL2H3qioV7zh50XA90Vb73MeUC+YQX?=
 =?us-ascii?Q?UpQeJTGFiGYpFA0l40T269CsXMRaTfTv8pMShk45r/u5xIbGw4h7OEDMBELX?=
 =?us-ascii?Q?YQpW4eWZvKU0CekvDpU1ozC5tLYTMInu+MlZ2OIDlKFIyJhtBcZ1bm46Ov7T?=
 =?us-ascii?Q?8AxuUcGf/lPVe7K2v611WFHgkZo/Z0iFPtAEr8or6wTNl18Yu9EsJ1i2db1J?=
 =?us-ascii?Q?Z4RVE2XMwPOWmDYQX4GtZ/WzQokhiW1bR8Y5MKQ5nT0XxcF5bC315RjocZq8?=
 =?us-ascii?Q?tNJk5D3kfz2/ydKT7Muf4NsRJspiJh58lRkJZxSL7zQb5uaUD9ka6dscZZ7f?=
 =?us-ascii?Q?l5RVGiQRBjqKFOECOT2PKvu6K62UrkZxBHv6PD8kFeOH38N6SPCORQrAkEDY?=
 =?us-ascii?Q?E87Vqq2gP0rGPrbVMNg9CfC2rTkGqmD1Xqb1cpmH+KHrE6Y4jJNgQUNZEkzZ?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50f50f5-87e4-4a38-9143-08d9dad40c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:44:12.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FS+NFyPiin17xZev1SyIlRsbIvwmtQXPY0Q1FeXmrf3P3iVygtvh1ZA8tydiVj6yrm6esmqrvfyNIhMjmdCCaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0923
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots
> with parameters affecting NUMA topology
>=20
> From: Long Li <longli@microsoft.com> Sent: Wednesday, January 12, 2022 4:=
59
> PM
> >
> > > Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel
> > > boots with parameters affecting NUMA topology
> > >
> > > From: Long Li <longli@microsoft.com> Sent: Friday, January 7, 2022
> > > 12:32 PM
> > > > >
> > > > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> > > > > Thursday, January 6, 2022 3:20 PM
> > > > > >
> > > > > > When the kernel boots with parameters restricting the number
> > > > > > of cpus or NUMA nodes, e.g. maxcpus=3DX or numa=3Doff, the vPCI
> > > > > > driver should only set to the NUMA node to a value that is vali=
d in the
> current running kernel.
> > > > > >
> > > > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
> > > > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > > > b/drivers/pci/controller/pci- hyperv.c index
> > > > > > fc1a29acadbb..8686343eff4c 100644
> > > > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > > > @@ -1835,8 +1835,21 @@ static void
> > > > > > hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> > > > > >  		if (!hv_dev)
> > > > > >  			continue;
> > > > > >
> > > > > > -		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > > > > -			set_dev_node(&dev->dev, hv_dev-
> >desc.virtual_numa_node);
> > > > > > +		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > > > > > +			int cpu;
> > > > > > +			bool found_node =3D false;
> > > > > > +
> > > > > > +			for_each_possible_cpu(cpu)
> > > > > > +				if (cpu_to_node(cpu) =3D=3D
> > > > > > +				    hv_dev->desc.virtual_numa_node) {
> > > > > > +					found_node =3D true;
> > > > > > +					break;
> > > > > > +				}
> > > > > > +
> > > > > > +			if (found_node)
> > > > > > +				set_dev_node(&dev->dev,
> > > > > > +					     hv_dev-
> >desc.virtual_numa_node);
> > > > > > +		}
> > > > >
> > > > > I'm wondering about this approach vs. just comparing against
> nr_node_ids.
> > > >
> > > > I was trying to fix this by comparing with nr_node_ids. This
> > > > worked for numa=3Doff, but it didn't work with maxcpus=3DX.
> > > >
> > > > maxcpus=3DX is commonly used in kdump kernels. In this config,  the
> > > > memory system is initialized in a way that only the NUMA nodes
> > > > within maxcpus are setup and can be used by the drivers.
> > >
> > > In looking at a 5.16 kernel running in a Hyper-V VM on two NUMA
> > > nodes, the number of NUMA nodes configured in the kernel is not
> > > affected by maxcpus=3D on the kernel boot line.  This VM has 48 vCPUs
> > > and 2 NUMA nodes, and is Generation 2.  Even with maxcpus=3D4 or
> > > maxcpus=3D1, these lines are output during
> > > boot:
> > >
> > > [    0.238953] NODE_DATA(0) allocated [mem 0x7edffd5000-0x7edfffffff]
> > > [    0.241397] NODE_DATA(1) allocated [mem 0xfcdffd4000-0xfcdfffefff]
> > >
> > > and
> > >
> > > [    0.280039] Initmem setup node 0 [mem 0x0000000000001000-
> 0x0000007edfffffff]
> > > [    0.282869] Initmem setup node 1 [mem 0x0000007ee0000000-
> 0x000000fcdfffffff]
> > >
> > > It's perfectly legit to have a NUMA node with memory but no CPUs.
> > > The memory assigned to the NUMA node is determined by the ACPI SRAT.
> > > So I'm wondering what is causing the kdump issue you see.  Or maybe
> > > the behavior of older kernels is different.
> >
> > Sorry, it turns out I had a typo. It's nr_cpus=3D1 (not maxcpus). But
> > I'm not sure if that matters as the descriptions on these two in the ke=
rnel doc
> are the same.
> >
> > On my system (4 NUMA nodes) with kdump boot line:  (maybe if you try a
> > VM with 4 NUMA nodes, you can see the problem)
> > [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.11.0-1025-azu=
re
> > root=3DPARTUUID=3D7145c36d-e182-43b6-a37e-0b6d18fef8fe ro console=3Dtty=
1
> > console=3DttyS0
> > earlyprintk=3DttyS0 reset_devices systemd.unit=3Dkdump-tools-dump.servi=
ce
> > nr_cpus=3D1 irqpoll nousb ata_piix.prefer_ms_hyperv=3D0
> > elfcorehdr=3D4038049140K
> >
> > I see the following:
> > [    0.408246] NODE_DATA(0) allocated [mem 0x2cfd6000-0x2cffffff]
> > [    0.410454] NODE_DATA(3) allocated [mem 0x3c2bef32000-0x3c2bef5bfff]
> > [    0.413031] Zone ranges:
> > [    0.414117]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > [    0.416522]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > [    0.418932]   Normal   [mem 0x0000000100000000-0x000003c2bef5cfff]
> > [    0.421357]   Device   empty
> > [    0.422454] Movable zone start for each node
> > [    0.424109] Early memory node ranges
> > [    0.425541]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> > [    0.428050]   node   0: [mem 0x000000001d000000-0x000000002cffffff]
> > [    0.430547]   node   3: [mem 0x000003c27f000000-0x000003c2bef5cfff]
> > [    0.432963] Initmem setup node 0 [mem 0x0000000000001000-
> 0x000000002cffffff]
> > [    0.435695] Initmem setup node 3 [mem 0x000003c27f000000-
> 0x000003c2bef5cfff]
> > [    0.438446] On node 0, zone DMA: 1 pages in unavailable ranges
> > [    0.439377] On node 0, zone DMA32: 53088 pages in unavailable ranges
> > [    0.452784] On node 3, zone Normal: 40960 pages in unavailable range=
s
> > [    0.455221] On node 3, zone Normal: 4259 pages in unavailable ranges
> >
> > It's unclear to me why node 1 and 2 are missing. But I don't think
> > it's a Hyper-V problem since it's only affected by setting nr_cpus
> > over kernel boot line. Later, a device driver
> > (mlx5 in this example) tries to allocate memory on node 1 and fails:
> >
>=20
> To summarize some offline conversation, we've figured out that the "missi=
ng"
> NUMA nodes are not due to setting maxcpus=3D1 or nr_cpus=3D1.  Setting th=
e cpu
> count doesn't affect any of this.
>=20
> Instead, Linux is modifying the memory map prior to starting the kdump ke=
rnel
> so that most of the memory is not touched and is
> preserved to be dumped, which is the whole point of kdump.   This
> modified memory map has no memory in NUMA nodes 1 and 2, so it is correct
> to just see nodes 0 and 3 as online.
>=20
> I think code fix here is pretty simple:
>=20
> 	int node;
>=20
> 	node =3D hv_dev->desc.virtual_numa_node;
> 	if ((hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> 			&& (node < nr_node_ids))
> 		set_dev_node(&dev->dev, numa_map_to_online_node(node));
>=20
> Michael

Okay, this looks good.

I'm sending a V2 (with a minor change) after testing is done.

Long
