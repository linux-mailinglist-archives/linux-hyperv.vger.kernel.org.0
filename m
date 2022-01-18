Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC108493115
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jan 2022 23:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbiARW7N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jan 2022 17:59:13 -0500
Received: from mail-eus2azon11020024.outbound.protection.outlook.com ([52.101.56.24]:15341
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344248AbiARW7M (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jan 2022 17:59:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny3wOHuEzVFC1Q82ibF0+F+mfSSbne/NHtJhip9g/sBfcNkY/cMd4A79sZeskjcHJ1lfSetE094j+oy1zOdTb/GYyvteN4theJ9kkH1/SWGS6mqX7NT0EsEORf9KO+FsJpI/nYy6cncJL4k2ZIXPsa4zMhXbacFZLr57eXFvrLnUkD5coqr2nmDWwUguP6Ek9AAi985/YPGaIeWK37ZHcwmHIbBDmKg62JksuKRB7aRBXJvIQeXQG08WyEjDzkyEc997pWb5na0RhRTvVv4ZYjRz4zaPzcw7fyQJ3U5c4ovVaoNTEswXVT9pINjShdZIgQ62jzweIU00BOtoosKxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnxQTKWpZjtI5BCxm7iRyCiCM96b0QazHjQbvluzpq0=;
 b=dOPhEaHHQrWs1lklNN91LjOWKvi05evFvMbg6vvegOHfKFATacNeYUwg/lEuTeUZ323JueBVcDasKjN+1+ss1oLRLeKUt5QBAagZW7TcVe6I5Kui3ZYW+gn479f5F5O/WxcjLOMhet+yWhBDkZYxUxDyQL64iQGRVD0SoXJm1Sv/Qf4DDsLIxYgA0Z0C9CBm9VVBm8tBOzw03hPwMRNiQI3gyundRxLNBy2RtJqhAHtScsOluoC4CDUd98z/NqLPIOmOBrwzWzq5gFXmmDx1C/IItgLQ5NzdV0J7Icuo+hitbuKhxjIQTDqpmosYYhbfmFU2Ioq92iZy7R+84xkPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnxQTKWpZjtI5BCxm7iRyCiCM96b0QazHjQbvluzpq0=;
 b=c+KAuT3x4w5mSQprqH906fZl++JxYNGV0RXXDa1hwdG3Zfn3iagfpWTgD7AFEwWWNE6iK4SaJHOtN4qfYj4FLs3lV4akMXyxeKtvUsqesRVLag1SpEjYj+/WXlmhNgACoIIuoqXHtK7UCvnxNeKS/zLU+j078Gr0/sZP1VkXYns=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM6PR21MB1211.namprd21.prod.outlook.com (2603:10b6:5:166::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3; Tue, 18 Jan
 2022 22:59:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::7478:bb68:bc94:3312]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::7478:bb68:bc94:3312%3]) with mapi id 15.20.4909.004; Tue, 18 Jan 2022
 22:59:06 +0000
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
Thread-Index: AQHYA1QWURfWxy//0UuSygYpK/bNEqxXrRcQgABXZwCABGe4cIADvrGAgAYErcCAA0OXAIAAA4Kg
Date:   Tue, 18 Jan 2022 22:59:06 +0000
Message-ID: <MWHPR21MB1593386F34FD34260FAE89EFD7589@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15938D29A4C1AF535E8510ADD7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B0D34E7C42B9B0337136CE539@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593B3FF426AFF5B3F7C35E9D7569@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506829683984FD91061D907CE589@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506829683984FD91061D907CE589@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1febcc33-d124-4e51-c89f-08d9dad6215b
x-ms-traffictypediagnostic: DM6PR21MB1211:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB121119901E9CCBB2E2E6DB40D7589@DM6PR21MB1211.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRB3Sn738fwMQalNwWuCSTJQI9nxrZpFYT5MZy0woKKcF1Mlr8+bgZysguwzFGKkVeaKK3APCcdk7cupnukELgqThUO/KWdzSyZLHpT/CCqqYYOpv/jhxY0qx8PEBJUx/Iod09bftgTfVEt4HOX35sM2YtPO65gI6UCGMKcKLZoGIkPC378/ngtpXoSg5ryp2Ubu+duBiEn79n5qIrrT67zF7ZMG9tQlcg4+0AidzCb2zQGHqpy9CFAho4/OqPkvqPUR0etcKDcbk4GZLa6bJUIDpnq1L/JRayt32xrvVkoaK04c+9nM1RHC3mgSkiynE15L/frDK/5v8nOX+ZeX0j7TMJQonIuC+bWTZungDmytR3w1LCMI7j7tON8+Y28lN3t82l5S0h5v2SMgC+Lt+d3X5SGWkgIGT9RpvO0b9MowXVKsf08xjgHE9yPNUWHL/H3bTI4YnD3YkQBkp/caMAtEtDLRDJs+ZHN0TMTfRLX+MvYRbsdanHVZtIURsEzlVtjWhulZJP2QXVCvA1ERpciPJ0BP22okpMHxHali5iJ9+jUQtcwH+xOylvV4oxzCZOA/lTmWT+mKvR+PTYqx7707C12tD7+h0WkQGEtJYXChrVEcvq6lBPjVxgh9Brjxb69+54AngUXcVAwsz3X0FfoFwMmWyBPF4pH+kY/tcCCrAmikbQRmIutb6KJzIHX6462XiVf/2KD5I8YgQAaFNp8qejP1YCiCAINH3ejcefUfpBwOx8u2HqyGFXkayLNm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(76116006)(6636002)(26005)(52536014)(55016003)(8990500004)(5660300002)(33656002)(110136005)(7696005)(6506007)(186003)(2906002)(66946007)(66556008)(66476007)(64756008)(9686003)(122000001)(71200400001)(82960400001)(82950400001)(38100700002)(38070700005)(8936002)(8676002)(66446008)(10290500003)(508600001)(83380400001)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4BUaXt4ZdpNzxC2vgOPdO+OdbEnVUn05toHhQS5Xi3MG54nCvYfZhR8xWjXZ?=
 =?us-ascii?Q?Ni/KaLo2impAVhPYRCxOt7h99rIil29JaSqVmJe2uziKTbQoVXRcUTtKgFKD?=
 =?us-ascii?Q?1MSPqgVSDSfLQTcipjYhAx0i5F+nH7/V9nk1ePsG4Y8H43DX/GmNZXgG5ozV?=
 =?us-ascii?Q?ZG3MqFtu4jxL8y8Cu8KlgQMVBu6HXCTBiK9D6x6wu5xWOtLjUnO1BgUak5lF?=
 =?us-ascii?Q?Qz4gnVKgZl7OehdhGUG+cKZPA/rKuGOuJypCz5UXSABhMUBMTYsZB0xO1zf3?=
 =?us-ascii?Q?vbtxsxgmCBRrUzJjNat4rNYVqVjAhWzJcvL0eiYI9Yp3PpzkasorIvE9QJWY?=
 =?us-ascii?Q?Ow39s/xIUR8RHK7FbTX9/6rCoDc3ADfobYEq2xV2nWHjUlnbC1zCF8SCjYSJ?=
 =?us-ascii?Q?T4uBHXqcEMoWeuHYrJylPZqfoskh9twBQxB6LZXeWJ8DxjsKcPfT8fJak1Ns?=
 =?us-ascii?Q?KlV7lXou6NTxdRZb2n+hJnwFhNXBPfbZu00Fk5BlkzbUdYavD93axi2h8EQd?=
 =?us-ascii?Q?rZkJhQ8uShbsIZkflJP8M4SrXMw63qkn9p6lf2NcgMn1AIBFWqc8VmraNOXV?=
 =?us-ascii?Q?tgcPyXwizh1fj3QXNrNuiCQDWI9WRVA5kEuzzXK9VTQ1utKL8YzvIw0wFNqg?=
 =?us-ascii?Q?34v0d6+FFCJr9Shf/0K9oLlAUghL/Qpjn39q5KAkAodNamqp8cUEFJZrjwUB?=
 =?us-ascii?Q?XBGvf6rn/TYiKKMQZvy/DufnOouXuFALb1U3ufy4IFdjRfA78C1NazYex3fl?=
 =?us-ascii?Q?guwW+vwv4jfRTAdGR8uN9gl6p6uzQGvc/QfE7DTVAezi9/aYIJ0CBaDpxYfh?=
 =?us-ascii?Q?+f69nzcnyzrKCeyMt+u0cAu7qtJIeERGbEl1eclzBnF8EGwPH3ZgAes493ei?=
 =?us-ascii?Q?eLEEa3MqOSSfqK5kgxb2qqo7NJ0ZdmvtPAFju2087rl+oIZZJfRc+5Ihj0mt?=
 =?us-ascii?Q?cb7zf87n3V8j6BjIcK+BQcbebltsO/uJyBpijdVoh4DmhZgqOEoiCaaoUo9H?=
 =?us-ascii?Q?S1Inv59WEW/KcorwCML10PrlTQ2l215CYNt9DjE366N3FfskDAjqNTeLHoA8?=
 =?us-ascii?Q?ziBQsHSJMvoJ7YtMTliPF0qt69sQGfQfa+sx62lVyE9MsoSsGxql1uTBGhPy?=
 =?us-ascii?Q?6Qv0Lc0ce/gC9t7SmPc4WvFogjmeUOEBWKGagc6k4QhsU7k2RVa+62T3xVwT?=
 =?us-ascii?Q?labDfB5OAfAHwvLsSVq7pREo00xduSwuIqrECbMcxNBWQ7eu0xAl3D0jlmnH?=
 =?us-ascii?Q?pKra1ksJMFnTF7Tgr/DPXOIIZHHhT2Ceyen063BhKNAW537ePDym/NDbo59a?=
 =?us-ascii?Q?t5zsPOMZBAOmf9CQcubzRqv3YvimePF17VrMCLcSKaaHZR9vKMVKZeI61Y06?=
 =?us-ascii?Q?XYQsTrfzg1qJPIbwqOktmvM1P7hvHPejCADm1dR3xZ7vl1uxRxkrt5fpd+dx?=
 =?us-ascii?Q?2JoASFgX0Z48WyGQpacxJeF2XwPORNHTSTrrRYduZUlydd0RE8iuXqzHb2TR?=
 =?us-ascii?Q?WKMXNxw1z6K6vhvCZ8K+L2CnFkqt7vGeiSQEZ161onopkXdtKyoPOo3naZCN?=
 =?us-ascii?Q?NF4KnoCI0wsZHxgB6OhGeYEHDdZ93ApmXsi5gLMGrGbaUnM7VISs3WhvdM5/?=
 =?us-ascii?Q?30NCfLvuCPEEVuBTQc5kyNG28pJGiioW2vHG9MmlNBZfMo/wKUSM39rrsFqe?=
 =?us-ascii?Q?rIqTzw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1febcc33-d124-4e51-c89f-08d9dad6215b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:59:06.4845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMSzadaVSH1s+7VoZSKcgzQm6gYKO0iCBkF1Ju5PfOuU750M10tB+QNrglNKPpXzyyeMmD02fFlgSjtHSpJOXgoewgoo1LqIfKEpzoplwoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1211
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Tuesday, January 18, 2022 2:44 P=
M
> >
> > From: Long Li <longli@microsoft.com> Sent: Wednesday, January 12, 2022 =
4:59
> > PM
> > >
> > > > Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel
> > > > boots with parameters affecting NUMA topology
> > > >
> > > > From: Long Li <longli@microsoft.com> Sent: Friday, January 7, 2022
> > > > 12:32 PM
> > > > > >
> > > > > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> > > > > > Thursday, January 6, 2022 3:20 PM
> > > > > > >
> > > > > > > When the kernel boots with parameters restricting the number
> > > > > > > of cpus or NUMA nodes, e.g. maxcpus=3DX or numa=3Doff, the vP=
CI
> > > > > > > driver should only set to the NUMA node to a value that is va=
lid in the
> > current running kernel.
> > > > > > >
> > > > > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > > > > ---
> > > > > > >  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
> > > > > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > > > > b/drivers/pci/controller/pci- hyperv.c index
> > > > > > > fc1a29acadbb..8686343eff4c 100644
> > > > > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > > > > @@ -1835,8 +1835,21 @@ static void
> > > > > > > hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> > > > > > >  		if (!hv_dev)
> > > > > > >  			continue;
> > > > > > >
> > > > > > > -		if (hv_dev->desc.flags &
> > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > > > > > > -			set_dev_node(&dev->dev, hv_dev-
> > >desc.virtual_numa_node);
> > > > > > > +		if (hv_dev->desc.flags &
> > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > > > > > > +			int cpu;
> > > > > > > +			bool found_node =3D false;
> > > > > > > +
> > > > > > > +			for_each_possible_cpu(cpu)
> > > > > > > +				if (cpu_to_node(cpu) =3D=3D
> > > > > > > +				    hv_dev->desc.virtual_numa_node) {
> > > > > > > +					found_node =3D true;
> > > > > > > +					break;
> > > > > > > +				}
> > > > > > > +
> > > > > > > +			if (found_node)
> > > > > > > +				set_dev_node(&dev->dev,
> > > > > > > +					     hv_dev-
> > >desc.virtual_numa_node);
> > > > > > > +		}
> > > > > >
> > > > > > I'm wondering about this approach vs. just comparing against
> > nr_node_ids.
> > > > >
> > > > > I was trying to fix this by comparing with nr_node_ids. This
> > > > > worked for numa=3Doff, but it didn't work with maxcpus=3DX.
> > > > >
> > > > > maxcpus=3DX is commonly used in kdump kernels. In this config,  t=
he
> > > > > memory system is initialized in a way that only the NUMA nodes
> > > > > within maxcpus are setup and can be used by the drivers.
> > > >
> > > > In looking at a 5.16 kernel running in a Hyper-V VM on two NUMA
> > > > nodes, the number of NUMA nodes configured in the kernel is not
> > > > affected by maxcpus=3D on the kernel boot line.  This VM has 48 vCP=
Us
> > > > and 2 NUMA nodes, and is Generation 2.  Even with maxcpus=3D4 or
> > > > maxcpus=3D1, these lines are output during
> > > > boot:
> > > >
> > > > [    0.238953] NODE_DATA(0) allocated [mem 0x7edffd5000-0x7edffffff=
f]
> > > > [    0.241397] NODE_DATA(1) allocated [mem 0xfcdffd4000-0xfcdfffeff=
f]
> > > >
> > > > and
> > > >
> > > > [    0.280039] Initmem setup node 0 [mem 0x0000000000001000-
> > 0x0000007edfffffff]
> > > > [    0.282869] Initmem setup node 1 [mem 0x0000007ee0000000-
> > 0x000000fcdfffffff]
> > > >
> > > > It's perfectly legit to have a NUMA node with memory but no CPUs.
> > > > The memory assigned to the NUMA node is determined by the ACPI SRAT=
.
> > > > So I'm wondering what is causing the kdump issue you see.  Or maybe
> > > > the behavior of older kernels is different.
> > >
> > > Sorry, it turns out I had a typo. It's nr_cpus=3D1 (not maxcpus). But
> > > I'm not sure if that matters as the descriptions on these two in the =
kernel doc
> > are the same.
> > >
> > > On my system (4 NUMA nodes) with kdump boot line:  (maybe if you try =
a
> > > VM with 4 NUMA nodes, you can see the problem)
> > > [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.11.0-1025-a=
zure
> > > root=3DPARTUUID=3D7145c36d-e182-43b6-a37e-0b6d18fef8fe ro console=3Dt=
ty1
> > > console=3DttyS0
> > > earlyprintk=3DttyS0 reset_devices systemd.unit=3Dkdump-tools-dump.ser=
vice
> > > nr_cpus=3D1 irqpoll nousb ata_piix.prefer_ms_hyperv=3D0
> > > elfcorehdr=3D4038049140K
> > >
> > > I see the following:
> > > [    0.408246] NODE_DATA(0) allocated [mem 0x2cfd6000-0x2cffffff]
> > > [    0.410454] NODE_DATA(3) allocated [mem 0x3c2bef32000-0x3c2bef5bff=
f]
> > > [    0.413031] Zone ranges:
> > > [    0.414117]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > > [    0.416522]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > > [    0.418932]   Normal   [mem 0x0000000100000000-0x000003c2bef5cfff]
> > > [    0.421357]   Device   empty
> > > [    0.422454] Movable zone start for each node
> > > [    0.424109] Early memory node ranges
> > > [    0.425541]   node   0: [mem 0x0000000000001000-0x000000000009ffff=
]
> > > [    0.428050]   node   0: [mem 0x000000001d000000-0x000000002cffffff=
]
> > > [    0.430547]   node   3: [mem 0x000003c27f000000-0x000003c2bef5cfff=
]
> > > [    0.432963] Initmem setup node 0 [mem 0x0000000000001000-
> > 0x000000002cffffff]
> > > [    0.435695] Initmem setup node 3 [mem 0x000003c27f000000-
> > 0x000003c2bef5cfff]
> > > [    0.438446] On node 0, zone DMA: 1 pages in unavailable ranges
> > > [    0.439377] On node 0, zone DMA32: 53088 pages in unavailable rang=
es
> > > [    0.452784] On node 3, zone Normal: 40960 pages in unavailable ran=
ges
> > > [    0.455221] On node 3, zone Normal: 4259 pages in unavailable rang=
es
> > >
> > > It's unclear to me why node 1 and 2 are missing. But I don't think
> > > it's a Hyper-V problem since it's only affected by setting nr_cpus
> > > over kernel boot line. Later, a device driver
> > > (mlx5 in this example) tries to allocate memory on node 1 and fails:
> > >
> >
> > To summarize some offline conversation, we've figured out that the "mis=
sing"
> > NUMA nodes are not due to setting maxcpus=3D1 or nr_cpus=3D1.  Setting =
the cpu
> > count doesn't affect any of this.
> >
> > Instead, Linux is modifying the memory map prior to starting the kdump =
kernel
> > so that most of the memory is not touched and is
> > preserved to be dumped, which is the whole point of kdump.   This
> > modified memory map has no memory in NUMA nodes 1 and 2, so it is corre=
ct
> > to just see nodes 0 and 3 as online.
> >
> > I think code fix here is pretty simple:
> >
> > 	int node;
> >
> > 	node =3D hv_dev->desc.virtual_numa_node;
> > 	if ((hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > 			&& (node < nr_node_ids))
> > 		set_dev_node(&dev->dev, numa_map_to_online_node(node));
> >
> > Michael
>=20
> Okay, this looks good.
>=20
> I'm sending a V2 (with a minor change) after testing is done.
>=20
> Long

Please leave a comment in the code as to why a NUMA node might be
offline.   In the future, somebody new might not know what can happen.
I certainly didn't. :-(

Michael
