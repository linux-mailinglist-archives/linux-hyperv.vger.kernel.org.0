Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA4487DC3
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jan 2022 21:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiAGUbo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Jan 2022 15:31:44 -0500
Received: from mail-cusazon11020015.outbound.protection.outlook.com ([52.101.61.15]:17845
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229962AbiAGUbo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Jan 2022 15:31:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD60yKP+3RLw1Y5b4w5QO6sA7ORfU4Gu8n9uwHGkwn87IesAWs+PPTZ8B//LPRIGJVaLgv5grwWOII6qVItsPvz8g+2FSTLdQqrRyolT3k3F3ZJyTl5DNqCPKXmjk/fCkCFv7/gxvV8amJlO5t7d0u6QKl7NOJT77Nnhpp4yPXYlWgRj+Pwa0qxI/2Eo1+juiknylpz8zvjptMHJxuZthRVafCy886ETQDoVhoez6tRaiFlaATDIgiM3Z79Kn3Wbqc3FEgGURYPtHz9f4X4n7A9vI5sVu9X4esIf9+P+zyqHk57CSh7d2nSkzLNrIGf20zxi8c3zKjfzqQvNkFfNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlvpJc+/oicR3UcOZT6iJFYpBDpRo3HH/8YaZseQcUU=;
 b=SJywLg/KK2Zb9580kHNOsVXA+N/SJigIaQ0u/4TqYqEmUsBaLFyCao4gq2YurGCDe1im2cXQMU9QQus37H6eq6y5XaWeNF4aZ9wzo3bsMa7nS9mkf8ajxhiZPnVEpZ++zQrr9Pf/4JGatWCAJXHAwpKyVxmbRtXY5Ct7lLETBxr2HRnBW4bW+AxHOKU882p5+ZEAa1McsUGRbxt9YC6YOEVXc8x/9yKV4Ea7/QlzkIPRBLzjI/BAYEU6z9Jp8ahZgBL4VrAvLkWMT1ZgRab/j5D+F4lft/mPpfUt9uy2/TOXoJtkoYa0gQXw4PrHmM8v9rR4lT8CV3Sg57ZV50+M0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlvpJc+/oicR3UcOZT6iJFYpBDpRo3HH/8YaZseQcUU=;
 b=NmFWaMFwqgeUdarFw6SJ6v36GACkhEzB9Hk0U7pOCCpxVna2TV5oAPclRqFYOmZwh0U3H0MmJrUWqGOtAF8Qgb4EuWflD5B2EXgRP2Hy1MDWj7Mif5TWsx1AWTM/Dsqrhsg3IFBR9Zh7XQSGpLnkN7zq2WXEeYxX5KNCYLlEFw4=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BN8PR21MB1268.namprd21.prod.outlook.com (2603:10b6:408:a1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.7; Fri, 7 Jan
 2022 20:31:39 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d15d:9006:d21:91e1]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d15d:9006:d21:91e1%5]) with mapi id 15.20.4888.007; Fri, 7 Jan 2022
 20:31:40 +0000
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
Thread-Index: AQHYA1QWLddhPIPNnk6mtn+/LlpFvqxXsWWAgABQoAA=
Date:   Fri, 7 Jan 2022 20:31:40 +0000
Message-ID: <BY5PR21MB15067D1C5AA731A340A7AF34CE4D9@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb49a277-e863-456b-e43e-08d9d21cb626
x-ms-traffictypediagnostic: BN8PR21MB1268:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN8PR21MB126882808F97C4A04525FAA1CE4D9@BN8PR21MB1268.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XIdtuSA2EBC0nDrZogyfgrd2HLej00uIkn5xeCNArEO4TeUMvyhIF5K+j37+6XCuGVAqwBIQ/Ybs0cgbjQsVb96obyIe1E70etyHfxrpbqM5i6Xobki50v2SsusXAWpy4ko+GiYJqXVeeDIa0DqkUl48HkKHh7gWOMdGFdBECQLbCSquUJz208yH51UOWGxO7yr0U3Edxunny+AcWTu49kr7s7cdFMQuKO/m0TjwCG4bbiioEr1japcuTwN7TvrzcTHC5r6uvpyWGtSyiriC121aJGOGxEPp1YF2t/YZb3lW6pwGHJL/4OfqUmIcQTgHS+vDX6He5dGS8aRjEHJ/re9USnmhi44TLFNomHOqlBVzyRZvoE2hCzyqkZaPqyYepI1/t7Y6IW7qj9x8Wx1GTYRo8D1W33eAu0u+xciX0YioT3fIdEctinbNHdU2b6KKyq0uUqjDnksI8SO7nPOy/ZgfhuqT3FaWQaTLMPeD8ydtKnMzRvzsQwqSAU5/M3IaMPENZDJYWQZ1bVeCKWZNK6YwxlqsllgofsIEjiAYnvLwc6fvJCX/bLSs9Ca9MF+jFGOGE0y56GM13D+k9P1WODMIm7ttyaRK07HuPWOmlsw3NOswt6jV+df3e7LUG76+ZzUX8kkkKrhcXvJmb13/4uaAP0vaVZIFj7JgAbVYOD3NvTGgaNV6EnW6SEPFjR26KGNNgS2gVlgcIjbNnrjp0PLIbxcXdN5EEnO/BVCSPxdlR0sP0gKa6tvy4sy8NsL7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(76116006)(52536014)(6636002)(6506007)(5660300002)(26005)(186003)(7696005)(9686003)(110136005)(508600001)(55016003)(33656002)(10290500003)(316002)(8676002)(8990500004)(38070700005)(2906002)(64756008)(66946007)(66446008)(38100700002)(122000001)(83380400001)(8936002)(71200400001)(66556008)(82950400001)(82960400001)(66476007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mv+dMIteeSEDXxYI0NjyEMKAL3d0l8yUqUOJSmQXbwG7eo0TFg2GC7cF89xU?=
 =?us-ascii?Q?5gz0AEIXJYdwOyHi7l27Ermcn+hdA/R/Ia8RqQ19JNSSWzupDXPbe4Ek+tzx?=
 =?us-ascii?Q?yMd1Fh1riLkooEL5Ui1UxC4MBQVyOgM+GkhSAsAMfBURFhrCa4IyDJNG8cPU?=
 =?us-ascii?Q?7GKsD7lzxSANwsO1UU6DvWeYPvM+Tg7INdcqRcDQiO+U0Jypc4vjiNtHfwsQ?=
 =?us-ascii?Q?CN+UiCalKrRmOxK5RqwbdKlis+nDah6J/cFNyVHLtECav27JONtnLHxNPTyT?=
 =?us-ascii?Q?/GJQIyZhWkNhH6Iz1Hmp2qzBVS7zja/iXcXAm54aZO3ECtmM+blAA6HC3D3i?=
 =?us-ascii?Q?jzAYY7+JFrHu/M83niFZdrrOIAw9EESuaa3cbfODCXJ/NOGdV+F110Q/avuv?=
 =?us-ascii?Q?Ecl20Ko8GY32i0tMFUZBoo1X1h32/9kfsqs0MAJh9O22iz5lAB2tulmKCcwP?=
 =?us-ascii?Q?iCbE7CnMU31UPZb8I5D1FSLiXDw9B92zo/9jR707qCcuCaDFLpcska/yuO8n?=
 =?us-ascii?Q?C4zXSBPKSf13pYxcxU+CoPUH3dG7QeNshL8pdIu9fu6ZO2eR1Rgc9pcUviaT?=
 =?us-ascii?Q?Ov0Gi3CBTpIs3Sm+/V8FbmGdMPo0JxX2BgH2z5xqJryFsFegKFQtw4dyWF/O?=
 =?us-ascii?Q?oe78klQWQj9L6NIqkHx9Zn2qAiMTFZcr+zzF2oMP3J6v1SE+5TDpGdnKcbmE?=
 =?us-ascii?Q?M+KD5DbWTy1jfnc+3mBo+z3AdLRmBXR4REkpg1JSXxWZj1IJ7hjcYDgdneHG?=
 =?us-ascii?Q?u/CZeUkk/KuRhXnfTP11FkzTjuRRZoXgxe7Pw2ufJhZ4pV970xuLr2pqufJK?=
 =?us-ascii?Q?V91BV3L9UW1U4H+rhl+JzM2EPqfufaD8DbpcGd1vTIaMnbA56NDBSe8xW8Re?=
 =?us-ascii?Q?LJSUzH0mR2IAY7qb5bZUDFtiUyGVpBrn/ybtAPq5izCL6dNuX9jYYtC74DLy?=
 =?us-ascii?Q?XgDr6az4h9fR3qGREDX3fdEaVjsAQeQ3xmEnzMQuHpJzqZMS4YdJ8Vz8LVIU?=
 =?us-ascii?Q?ew45MW3rFWsx1AWgS7fOenUhemm3KIsKkNhtK4ivcTsWdAT17PP8MkRcDueN?=
 =?us-ascii?Q?xO4ANLxmoTCS/YU3PualTK0XOIHgz6BFbIcGPy3BWTMSGvd7/zegvwj6cOp+?=
 =?us-ascii?Q?4iHdM18cArkqzl3s6qMYFmuurM2TgtcaWTGZ9YLMiqo8bfbFGFE9JRq3qRuX?=
 =?us-ascii?Q?1PbEXs+DWRx+R/9HXCyxWqWIVLi6B5605bVeomvFpWw6ZlVcyoYCo12JGZUP?=
 =?us-ascii?Q?bJdN7/q+77Lqb8pdobU+ugQx9BcrCPjMIPvNFxNEHsbA6MXDxPFrxERTj+P0?=
 =?us-ascii?Q?SpnPmgB7q6hX/R+a16nO0ba1fN+LJkwjm2OPlY2UqWDnM5YDNs6fWntStCKI?=
 =?us-ascii?Q?VoXaWm62HDkaberWB27Ul5hFI+6Y/nwyAXkpJB+SogWAUpJyRUq0yPe/CoQT?=
 =?us-ascii?Q?AzonJ/nNaUkS/VB5gSyXrJuarzAC6ThRhAxr487dwaGt074tZm5cIgoUGGUK?=
 =?us-ascii?Q?na1PQ9CP/ydlz54ivJ3Q7dowN8dZmcy2S0bwB0yVCM/MUiXvjnwadN7+3B4H?=
 =?us-ascii?Q?YghvGcdlP4L3HmD+Na3E1yS/bZ1hErl8W8yz1o7PmZA6FOxcHvCe1hjZu04m?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb49a277-e863-456b-e43e-08d9d21cb626
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 20:31:40.4855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QV1pLZA6Vp3H2xu7gIOn9FVt79cmZIhqLfrrhifhd837R9v7bdTbSj8ryMixwlXtWiHh/9u4u1kels4YmMcjYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1268
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots
> with parameters affecting NUMA topology
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Thursday, January 6, 2022 3:20 PM
> >
> > When the kernel boots with parameters restricting the number of cpus
> > or NUMA nodes, e.g. maxcpus=3DX or numa=3Doff, the vPCI driver should o=
nly
> > set to the NUMA node to a value that is valid in the current running ke=
rnel.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci- hyperv.c index
> > fc1a29acadbb..8686343eff4c 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1835,8 +1835,21 @@ static void hv_pci_assign_numa_node(struct
> > hv_pcibus_device *hbus)
> >  		if (!hv_dev)
> >  			continue;
> >
> > -		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > -			set_dev_node(&dev->dev, hv_dev-
> >desc.virtual_numa_node);
> > +		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> > +			int cpu;
> > +			bool found_node =3D false;
> > +
> > +			for_each_possible_cpu(cpu)
> > +				if (cpu_to_node(cpu) =3D=3D
> > +				    hv_dev->desc.virtual_numa_node) {
> > +					found_node =3D true;
> > +					break;
> > +				}
> > +
> > +			if (found_node)
> > +				set_dev_node(&dev->dev,
> > +					     hv_dev-
> >desc.virtual_numa_node);
> > +		}
>=20
> I'm wondering about this approach vs. just comparing against nr_node_ids.

I was trying to fix this by comparing with nr_node_ids. This worked for num=
a=3Doff, but it didn't work with maxcpus=3DX.

maxcpus=3DX is commonly used in kdump kernels. In this config,  the memory =
system is initialized in a way that only the NUMA nodes within maxcpus are =
setup and can be used by the drivers.

> Comparing against nr_node_ids would handle the case of numa=3Doff on the
> kernel boot line, or a kernel built with CONFIG_NUMA=3Dn, or the use of
> numa=3Dfake.  Your approach is also affected by which CPUs are online, si=
nce
> cpu_to_node() references percpu data.  It would seem to produce more
> variable results since CPUs can go online and offline while the VM is run=
ning.
> If a network VF device was removed and re-added, the results of your
> algorithm could be different for the re-add, depending on which CPUs were
> online at the time.
>=20
> My impression (which may be incorrect) is that the device numa_node is
> primarily to allow the driver to allocate memory from the closest NUMA no=
de,
> and such memory allocations don't really need to be affected by which CPU=
s
> are online.

Yes, this is the reason I'm using for_each_possible_cpu(). Even if some CPU=
s are not online, the memory system is setup in a way that allow driver to =
allocate memory on that NUMA node. The algorithm guarantees the value of NU=
MA node is valid when calling set_dev_node().

>=20
> Thoughts?
>=20
> >
> >  		put_pcichild(hv_dev);
> >  	}
> > --
> > 2.25.1

