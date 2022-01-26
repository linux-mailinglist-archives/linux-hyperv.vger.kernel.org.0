Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE50249C10D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jan 2022 03:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiAZCLh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jan 2022 21:11:37 -0500
Received: from mail-eus2azon11020017.outbound.protection.outlook.com ([52.101.56.17]:32507
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233572AbiAZCLh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jan 2022 21:11:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui2cwG6KIGcec9cLVjbljdu7HnrdcF8AVR7+WXcMN+jeSgMirCB3w5fWHmcbAqwLmnkAe+epJbSy2WVJnOJsQeKyw7kxJN9yoddMzmJYzzreeU3WsqfT9oLujj47QNNAMhU0qt5grSf+k3LSYBQAScHgVtlmtHorpttBJqYDXPrSxT73vKfDVaEmEAJxBvWgEGFTXkzCqHnDYZ6Xmez9xUAEfWoGVGODokC3uKIVf04jSEhyu4xxQ1agvBfU0uL4Q2aa4TS2ZiT30KGnuBpgsfWJqbnOpKQXSZ4D5kocH2IZX8ih+eWEnz5A3KyLsU0ywmeIucCZQ8wQLPNentEDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+FM+0Ebfp/UcznRwgxnCehpV32TSyqUkRjQbhUyo4=;
 b=oNuADSzDTVQkvN/yW2b9KgEG5eIupyI0Z/smAg/cgRHeh9Mjiul/fOs0bjv2j8Pywk1VQDfZt9XZl/wT6hPV0zYQq8dxMDmH3VC9OBic+rXErCwH3BVA6KSkTJ2Y+vOlCLMn3O5ChC06q1E1KrGWiwo+h59gjemRmE+C3qjU18GPQ7GRBx5Va7m0lxFGsrRUJuEQC9Z5K+nr+xz1WtBRbwXqmiB2S3sd6izb9YyOI0/EWH+90nIjzCVcaXEL9r4Iefgu50QGFuw1ufVsUHneNSt5NFVP6pondCu0GbD5m3BSgDvRZeAb2fW2x5TODJaScdoNo4byGOqqkOKwBvj8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+FM+0Ebfp/UcznRwgxnCehpV32TSyqUkRjQbhUyo4=;
 b=ahiPlL/taz8oOQsODPfQj0fZKGGmcHKcSrnY2CAAFy28whBMMeAX4FQuTHDpxIW+uk+6r+n4yCTPfEARtsL43aaEtyL+TObVXuMAflkvKvqNYk7thsbEsrPHBkCWdWoDWiBKhLfKZDAyRkCaQtd1/VM2i1zx/9ogsjUmKG4QmRg=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by CH2PR21MB1512.namprd21.prod.outlook.com (2603:10b6:610:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.4; Wed, 26 Jan
 2022 02:11:31 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::740f:6146:70a3:f030]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::740f:6146:70a3:f030%6]) with mapi id 15.20.4930.009; Wed, 26 Jan 2022
 02:11:31 +0000
From:   Long Li <longli@microsoft.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
Subject: RE: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Topic: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Index: AQHYDW8KfQc40Q0LSkymOnkXww8gnqxwcAeAgAQo+2A=
Date:   Wed, 26 Jan 2022 02:11:31 +0000
Message-ID: <BY5PR21MB1506581FBD71CE22CE88A9F8CE209@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1642622346-22861-1-git-send-email-longli@linuxonhyperv.com>
 <Ye0wSwQhsnk2nB8z@unreal>
In-Reply-To: <Ye0wSwQhsnk2nB8z@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b28fd0c6-262f-486f-aae9-550d7860e843;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-26T02:10:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 734be66a-8059-4b84-b825-08d9e0712bae
x-ms-traffictypediagnostic: CH2PR21MB1512:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CH2PR21MB1512CEF40002384F7021331ECE209@CH2PR21MB1512.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WvfU6KsgEKyGvd8QfM8YqvK4bCnEPaXIL8YfcVCQGn9Z9QNiGwJiI6WysMT2asXx6ai3iApvlSgaFDF7ojr6K5oqG7jL4QgKXBvRX+o8Mo5y6Kmzl7NPBYGlbN9OzHz1HWd6/7nUIx6XN79SqXzibOacfDsG2e7l9I6ZZ7DAafZn7sCJbPozXGuQRT9tWOzqkTV19gUEMm7O5oVJvjsVmugNLYDcFaPIDdazTE7BViMf2uepCc0c44gzEhcBhfDoDlXZUwAAdPtCjp9f+H1iBsrp7LAcGyXhjy8LQlMttQiJRgUoVhXJgJYTruIIlr5KY2CELSvAuWJ6WhUlAoF3TEtymUjEgslXoWRZW/cqEJlCr5CWBgxyQIbfVkJJOI10NjYaQsfe9TMW/daFa6Ke15Z1T6m3YdVFZMcR1gNKkqAsn8UVcSdLEnvWtpvfCRLZKhcn8vguOeyargP99Z0GxyELyW3OhvaD6TS7RMPJhiy9jw+f0DjD1bOHIAKYFz8OHMStBIB9BSpFFPhWOj+1EMq7tpvggIWR7bukrSm9sAipmJKWn1ucaQsdoV57s6X3Vi+4CdyIBhv8ZwIiYGY662QGVexrLPJ1TunWVRbOINQZSYFhepSsgNu88uXvmP6zKbxw7uoEAu1/I6Wz/7vtQg58YnmxKIMKROS+zLO1W2WiOLPUNdxTOSoasl8V6PBtTQ5rNunYZN44OurkZYcsAp1Jksr2TMmR5nZRh+r/6E5pehoEA2qe/OG7OiKBmqw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(10290500003)(83380400001)(8676002)(66556008)(66446008)(26005)(186003)(8936002)(4326008)(64756008)(66476007)(52536014)(66946007)(8990500004)(71200400001)(107886003)(38070700005)(33656002)(5660300002)(110136005)(38100700002)(508600001)(2906002)(86362001)(9686003)(54906003)(76116006)(7696005)(6506007)(82950400001)(82960400001)(316002)(122000001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7dkEZilRYqbYaPho3OBFXsfloePiuhYb3Ko0MFwXUoMDVZve6DjQzeZ3X4Mt?=
 =?us-ascii?Q?KZhvwidl2i58Z+L20xhPRraNC4JXIupt2jw6wSMhUpeCEDlFoDca1hEY1Dgn?=
 =?us-ascii?Q?u5s+H7l0OTraLdlC5uW0exYWSXMOrcYOwUwmoLyVmhI1EJCYON7Fg4FAcfnw?=
 =?us-ascii?Q?41ApWEuPNDWKRcBkzt3fy+PycpZ76LsSuJLGPTv4vPm1XEhKlt2FNn+Cznr5?=
 =?us-ascii?Q?9oFEGW06nKLGBaitVPs8vWPrkDDfPLzT0v9p5uLT1FjOSznN61oGmulpZoIa?=
 =?us-ascii?Q?l8s+tG86p/8vfQzsPrLWQ8o9QmwODIVESAaAAnNlMt6+bRI0JI9759bmxhcg?=
 =?us-ascii?Q?DsTCodIUv0VHm7uFZZXnOPJZoeuFt77ZaQ5ZOBJur49iUGXhhSUPp06HAGaB?=
 =?us-ascii?Q?G9Bf7lk/dxBio2/++mojYwVsnZBFIshloRSCFckq+nCksQXpmEE086t9+E69?=
 =?us-ascii?Q?QkUzFlaKLrskFX/Ph7/9o9pVZ6Bwhex4GHH3tYVLPgFB0bA+eaS+1eFzTX9+?=
 =?us-ascii?Q?Z8V6AO7ROm9/tr7cTKKz7xtBMpd97yCVZehUYPnCYgm3pnG9iy6vEYk4AXo4?=
 =?us-ascii?Q?47+YgZWVfJJRqEnZJGd2YSVoqtBp+pWsm5LoNylKq/6qZYznBXrLIbXRVkKd?=
 =?us-ascii?Q?oUisIYW/RInS1lcMo1xNBSeC8v9aywj+BwWbwxeMbWcaSCFOlBj6fsRqo0T3?=
 =?us-ascii?Q?h+RIOODbHFnGvnOMfwTI7C95kLPWhK2ycxi1xwjf5O7ixZFTyEYiB7YAqRiL?=
 =?us-ascii?Q?6V6nhOOTG4FN6CWr9n2nr+cICq9CIcWb+lKBHQ5lG/NQsVXgYe1BnkHVNsBp?=
 =?us-ascii?Q?z1j25YvS22ImQ9dLNreGCgpz//BgYvglbEbjMMh8VQlhZGRSb8MwhBJlTgWr?=
 =?us-ascii?Q?Yc1E7xH1xjau1xRnXTGllNSViGa48goC6GhCcBUM2mkvxDTCn7HZ1F6A8Hw9?=
 =?us-ascii?Q?bA0sVW5AYKbhCr7MH2aKuru8J4gr+TNh9fiPhTO/OxV5tIGoX6ekU4HMNEJh?=
 =?us-ascii?Q?uk5i1tAGy/mRPSgsta4n1O5RKeTcYhCMtkxxBHGQKHGuxT0CAv6KIifb71zp?=
 =?us-ascii?Q?9dp6A6KAB/gZag/QD2DRccBTSKM2nJVNAlQcdLCM2RemIgX0jRqR9lIyTPET?=
 =?us-ascii?Q?mXfQgI20VTHTLBFXqd7Pbi42Ka3jQ+wBgJonIOVgQsvm7352kXl9GGzcCd6T?=
 =?us-ascii?Q?xpe7yFdbxj+fTd5o3SolkkSJzlRIEIFdxvflefGujkWLfGDuN/CP/1Vp7/zQ?=
 =?us-ascii?Q?viUJ8Pdp7odS0LGf5X17iC4Q2IQ+iR9OELBD3h1+w88qVxzZ/X8VSouuzMcD?=
 =?us-ascii?Q?YCooS2wNG0FazLzJPrWImw16O/fqOLINZ5GRlYLt7UAaSanUpq3g+kDXp8WQ?=
 =?us-ascii?Q?YHuo/66Om4I38rgcqVcMGx93/E80vpNfZsKFN5pMu90z+tdCgO0aVgcytItB?=
 =?us-ascii?Q?21p//P1zLrLTws5QQwKZZOzWcHRrCG76ghL65r/zzrLU2ATAK35lmnksN/H7?=
 =?us-ascii?Q?2uKqrRQzsEDgBFLDCwnf+2ucF6gnKmjQwGroc7OgXJ2g9aTLesWbf1PppPub?=
 =?us-ascii?Q?VVmUf1G2vQwaRAWJbdXi7PtirkfQxb+teBTyh+LAeJ7QGYHDm786570YXZD9?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734be66a-8059-4b84-b825-08d9e0712bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 02:11:31.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnbgYvYtaVthg7hoE6sNI3a9kJKY/1SWtu7A62C+YuRG6EjFra+rzEzJNu+Gtd92tZaAYAWA79KWobN5ibh4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1512
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boo=
ts
> with custom NUMA topology
>=20
> On Wed, Jan 19, 2022 at 11:59:06AM -0800, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When kernel boots with a NUMA topology with some NUMA nodes offline,
> > the PCI driver should only set an online NUMA node on the device. This
> > can happen during KDUMP where some NUMA nodes are not made online by
> the KDUMP kernel.
> >
> > This patch also fixes the case where kernel is booting with "numa=3Doff=
".
> >
> > Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and
> > support PCI_BUS_RELATIONS2")
> >
>=20
> No blank line here, please
>=20
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Everything below needs to be under "---" marker.

I'm sending v4 to address the comments.

Long


>=20
> Thanks
>=20
> >
> > Change log:
> > v2: use numa_map_to_online_node() to assign a node to device
> > (suggested by Michael Kelly <mikelley@microsoft.com>)
> >
> > v3: add "Fixes" and check for num_possible_nodes()
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 6c9efeefae1b..b5276e81bb44 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2129,8 +2129,17 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
> >  		if (!hv_dev)
> >  			continue;
> >
> > -		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > -			set_dev_node(&dev->dev, hv_dev-
> >desc.virtual_numa_node);
> > +		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> > +		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> > +			/*
> > +			 * The kernel may boot with some NUMA nodes offline
> > +			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
> > +			 * "numa=3Doff". In those cases, adjust the host provided
> > +			 * NUMA node to a valid NUMA node used by the kernel.
> > +			 */
> > +			set_dev_node(&dev->dev,
> > +				     numa_map_to_online_node(
> > +					     hv_dev->desc.virtual_numa_node));
> >
> >  		put_pcichild(hv_dev);
> >  	}
> > --
> > 2.25.1
> >
