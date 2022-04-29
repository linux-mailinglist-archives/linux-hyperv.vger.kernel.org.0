Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBDC514FDA
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Apr 2022 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378628AbiD2Pur (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Apr 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiD2Pup (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Apr 2022 11:50:45 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E824332EC8;
        Fri, 29 Apr 2022 08:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYxxyRXcaRGcEDvwtk2P8xZ2hFE6pU2rddRtLVWRHpQ0bAiOJnH0VUSxRCYnor3r65aXHihmVPpv7qasafO76Tc3/J2jR0xCrX4fICeagbMWVfoRZCHSVRBEFAazJM3AZv1wWL/7qOP8BTSAlkvgkT+fNeL67T+Y3VMshp6cV/8kOwTZJWpOIoz4GfnTH+0lBxU7uANDNWhOU0yPOVTv8MRkdJU3JhV9WHAkGMEjo6ma67zWbpM4luY7cYEodrvB6uqf69CrFM4A/miKehwFaIwhfvuA5R9IznkRVRwbml2+yFwCnEsrKn0s0yzNGmWtGzDpqttZvDwRIuWIfskDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sWm4f6thTdwF861VwrFqS8WlzWzHEKu8A3rwoBqOBo=;
 b=CL0hi190ieHFoVfIygmjtZ3H9EzKBXGeX1oHEnpywdFNnTvD5Xtsw+zs8cLsA1IFER401/2EuT66fqTTzCgn0GnxME0sEGDlQhHqiBWXsNLbMxFgipXIXoc1pWEf9vQdBzjH4bH/4K8hJ+9sqZcW6PbOla/ozi815gIzp4GF+sO2+Vq7C1VDfD0BQLdbu1DWoyVdb08l8vbQdeaxocHBCSqtjRmoVZPoMLhc+PuKCFLqr0taHBoVUpoQpriMeJ04gWFhsWbkx4ymhBlKopc51vn22kwhEWHchunafCmbL/NYf804PY502s3gxIVurL3K2Xgm2+RhE0/BpUSt4nr9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sWm4f6thTdwF861VwrFqS8WlzWzHEKu8A3rwoBqOBo=;
 b=fSyYN9p1BJ8aqcfmc/nrLS20hlFEpDOENQ5Cc5OZl9cftuCwzjnHGcaOyIUITp3Gc73/dPjjpDWErSjwN59NGb2xSarlwZ561J9rC+6TiZ1zEs3RiuO9b9u7ZEeMe4cLyaKF1S3cgJOnlQfWuH7zjLGdXGRYUxrTaUjrB8slYRs=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BYAPR21MB1653.namprd21.prod.outlook.com (2603:10b6:a02:ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6; Fri, 29 Apr
 2022 15:47:24 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::2823:3bd7:8a28:4203]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::2823:3bd7:8a28:4203%7]) with mapi id 15.20.5227.004; Fri, 29 Apr 2022
 15:47:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time
Thread-Topic: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time
Thread-Index: AQHYW7IFvcsiN9FVXkqw5/CaiO9kaa0HB8Sg
Date:   Fri, 29 Apr 2022 15:47:17 +0000
Message-ID: <BYAPR21MB1270E9923364F065D70086E1BFFC9@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <20220419220007.26550-1-decui@microsoft.com>
 <Ymu6tYItgM6dtNdd@lpieralisi>
In-Reply-To: <Ymu6tYItgM6dtNdd@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=289e2a47-9c55-4efc-ae08-3c054917ecb2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-29T15:41:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91b0096f-b442-4f6e-bbb7-08da29f78a38
x-ms-traffictypediagnostic: BYAPR21MB1653:EE_
x-microsoft-antispam-prvs: <BYAPR21MB1653E1CC58627211719F0B15BFFC9@BYAPR21MB1653.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIWNWryZlBdMDKTnAwa592V7whHETto9RTI4Shzh23mh904hoPEsncgA/TSscAE8053T0dbaxAJAQZazn+UsLLjjaOHUYbBiVVjNLIMs5vYrSYqDKA9E2A6pCKVkR2gRBkSnKmbX6xzxi04qVWFAJRWbtPvSqoN0KEtHMOYTY2b1yCLGpHgMFvoVUGTeG4UwBRD9NtuZFY7umSbGVON/GiAP6oTF8u3VJXUjxKY3OA44qk9/Kkl/aMWXA9H566r+VVlyqv9qfIe/HDNX5bf4waXAuxpY6JbvJdWqLo9cl3YAh9RyXuWISd9mGV3EOY9KTwjpxO17Vr4GTaYa1cBThq12sugdzBI3q7OyqdXdSJ815HAM1TLIdsqSlfUy8d2VExlChs6fT/r8Y3Nv5uvn3sXMuPI0WAU+H1mBgOj+Q6blGO+1/uI/hIkSiPHPmLAg5Ptr1QPciq5Eg3yyiY1TtYvY0NUOAdUmATdZjCBy+9IfZkWaznfLVBaPvOB5ekwJyFDRzfaQ7D9377fjheDLSjRPLDesaEU1GAD9aepm70XviT4GJTQWvQUI3CFqKeTzKK8j30b7sw4uFaFLmUMYt+a/KgyxorKFmojYTMvU/C7itkVw+tE+rIW83Fqv55GXyRQ4okN613Beg5lra0fyXxR6+QHijhc/XquAcSD/kmVSuHiyzOSz9B5DcjsYWQ+Jy7krh/JcTPKu7VWnJWTsWemeKJ0J8k7JwdOFOZ3EFs+BcMlmRCVe+uyXHeMuDC3v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(86362001)(122000001)(76116006)(4326008)(66946007)(5660300002)(38100700002)(71200400001)(8936002)(52536014)(8990500004)(55016003)(38070700005)(107886003)(186003)(54906003)(66556008)(8676002)(66476007)(64756008)(66446008)(33656002)(2906002)(9686003)(7696005)(26005)(6506007)(508600001)(316002)(53546011)(6916009)(10290500003)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BY0keluQnXIPP/XfrYAOQ8lx3zJaNCqZohejENJu74Y9tiWcHRTRMzul6O9U?=
 =?us-ascii?Q?zWehOqIICqv8q9obKL1fQVK3tsNDlbN7MCbEDG9zJHqW5NYhIK/Fy1FTTkA8?=
 =?us-ascii?Q?usuSfo3ZInkK3RNEYwTlJ1zulbFt9w3dcU1tCau3b0Wj11wkp+nAKXSq3qKs?=
 =?us-ascii?Q?Is74d3vfNidavhlEyXqJGZhCyQcPBh5xRkZJAV0b0aD4WfyZM9HarH3NISSw?=
 =?us-ascii?Q?vOhfk5GgvHiuUh5u+TFzPfndy9AbRm4G/g1mbHoWrkUtWtvxDGSCxjNXnAWc?=
 =?us-ascii?Q?S12paamHY73T5DzAadhQW1PHI0Rfw1fUpJQl5eM+hvBjBg/AcH4G/VXytF/5?=
 =?us-ascii?Q?QH8LrUWqkKVoD74NbYs3ch7uz5VQH+g4ARJNPhlmM2xDYluFwDc86UqXiu8R?=
 =?us-ascii?Q?2qLCJ9RxEOGd52h+fbh0tO4JbcVv23UrnSBsJYCqrvDdJAjzG9A+TduqAYK9?=
 =?us-ascii?Q?RWkgCWZkCWaNuNMGByhZDZFEK3iIDqelmXepIVEEVWlVH/GPKe2G7E9Q3RmZ?=
 =?us-ascii?Q?feqIbL3SKmFQeJb1K5FdzsaC8i86nBu/PxqkZ0LZ1zK0Q9vK8c6Ke+hn2gzM?=
 =?us-ascii?Q?NLsa9/dNG4UDgrmHyDzUFmiLwIXfeCP7maaqiybciaj/BkKrj8g2D42ewGPu?=
 =?us-ascii?Q?eRx3hMOWxBZ3WWkUMWTVXKDCvtlcCD/KYetwg4HmA8Y+glTw1XW0gaw1S2ZT?=
 =?us-ascii?Q?TDoY1mkCPspy9KsRHbuK19oHTsjUMKzb7vWIqxdfcVjSUflwZbOl4imb76qB?=
 =?us-ascii?Q?kZTbRCrKALDriQhd/f0qqrdjq2hpTFYkxkddQdRYDJMYfFzlmHO4JDH/aK+3?=
 =?us-ascii?Q?Rvmpk/KnReGYRUkv/Zg/Ia2NXk5PewsM1UzJDa3QV0YyJXyCJgLuf8pgWV8Q?=
 =?us-ascii?Q?/z/R0XIx2xZ59Rg4uMqvFenopNWZndqSr5artSj8nW3M16H8SxQX7UzPJwk4?=
 =?us-ascii?Q?VCeQimaeGtRuhx451Jt2sYYL5QzBGJBhBIg/pK2SzY/nrzmjwOCkShKjX+gL?=
 =?us-ascii?Q?V8uyamVraljx1h/gASNVW5fHBDHhaWDJ/NWvvn5len/h6apM9/4CdbGZuApC?=
 =?us-ascii?Q?E8ikzsnVr6ZZdPMetSN+El+Cy5Lrh0MD8ToC5c6pY+j3dyA67AYxbwnEvMB/?=
 =?us-ascii?Q?QpUDPbkZNXXr03zAxUeTmYR2czR8F8VsAiBAXhpDYF6ReFk77Iv+YaUI/tby?=
 =?us-ascii?Q?TVGLa7WBOEDDUCi44QvjA4yzR0GiqWpxvmK1g+CXAx/0VqghsW9VfosGZ3Jn?=
 =?us-ascii?Q?ME1o43VtKTVCO8WEbA2BRFyQwha1cBXCuCSA/qb8r0g4nRZX5jSmiGUTYpxX?=
 =?us-ascii?Q?i1r8lDXcv+B6bSQtKQkLbKZFH3vi2P4/UVoGaoNw/fSaSAd5mpafsXhXhHVa?=
 =?us-ascii?Q?oJPri325bozyBexu8i6G0+N2BhzpC9M8+44Kun8hzm7ikBPBk2XbbV17iteJ?=
 =?us-ascii?Q?5L8nEpcYUS+LKC20++tkVVentkciKikF62v62Zg9hwpUDUDNFOpJuWvDzCTL?=
 =?us-ascii?Q?boG9DMvDMZqS1QWjgvDDVgL9iLeZfCBVrr/KTTI+YqzALDr+fdKt5L3AGaEv?=
 =?us-ascii?Q?j7ewTO7Ruh99bABbR/zKprCJmITv6xtnMnl73uIkWkkoqbBaCIYAVNSkpimQ?=
 =?us-ascii?Q?HW+egCllsNqEe++TdE59Mo7gTwl/NElV9RAhbzSv0R+2fNXz8xyo+BlrL8bc?=
 =?us-ascii?Q?Genk1TbQln6zupjvhbTt95qRJUv5ZctMnrutnVcwtfyhsM38aMa/4YM0MXC2?=
 =?us-ascii?Q?+kiQ5YvwEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b0096f-b442-4f6e-bbb7-08da29f78a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 15:47:17.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCpxE6omcYLT33FYer8WrW9cfJTfCUQfTyQt9WHAcecqOSv19Gb4fQFcUUDNo3fJgJg7Dllllo0RY2xpyxs16g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1653
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, April 29, 2022 3:15 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: wei.liu@kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> bhelgaas@google.com; linux-hyperv@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Kelley (=
LINUX)
> <mikelley@microsoft.com>; robh@kernel.org; kw@linux.com; Jake Oshins
> <jakeo@microsoft.com>
> Subject: Re: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce
> VM boot time
>=20
> On Tue, Apr 19, 2022 at 03:00:07PM -0700, Dexuan Cui wrote:
> > A VM on Azure can have 14 GPUs, and each GPU may have a huge MMIO
> BAR,
> > e.g. 128 GB. Currently the boot time of such a VM can be 4+ minutes, an=
d
> > most of the time is used by the host to unmap/map the vBAR from/to pBAR
> > when the VM clears and sets the PCI_COMMAND_MEMORY bit: each
> unmap/map
> > operation for a 128GB BAR needs about 1.8 seconds, and the pci-hyperv
> > driver and the Linux PCI subsystem flip the PCI_COMMAND_MEMORY bit
> > eight times (see pci_setup_device() -> pci_read_bases() and
> > pci_std_update_resource()), increasing the boot time by 1.8 * 8 =3D 14.=
4
> > seconds per GPU, i.e. 14.4 * 14 =3D 201.6 seconds in total.
> >
> > Fix the slowness by not turning on the PCI_COMMAND_MEMORY in
> pci-hyperv.c,
> > so the bit stays in the off state before the PCI device driver calls
> > pci_enable_device(): when the bit is off, pci_read_bases() and
> > pci_std_update_resource() don't cause Hyper-V to unmap/map the vBARs.
> > With this change, the boot time of such a VM is reduced by
> > 1.8 * (8-1) * 14 =3D 176.4 seconds.
>=20
> I believe you need to clarify this commit message. It took me a while
> to understand what you are really doing.
>=20
> What this patch is doing is bootstrapping PCI devices with command
> memory clear because there is no need to have it set (?) in the first
> place and because, if it is set, the PCI core layer needs to toggle it
> on and off in order to eg size BAR regions, which causes the slow down
> you are reporting.
>=20
> I assume, given the above, that there is strictly no need to have
> devices with command memory set at kernel startup handover and if
> there was it would not be set in the PCI Hyper-V host controller
> driver (because that's what you are _removing_).
>=20
> I think this should not be merged as a fix and I'd be careful
> about possible regressions before sending it to stable kernels,
> if you wish to do so.
>=20
> It is fine by me to go via the Hyper-V tree even though I don't
> see why that's better, unless you want to send it as a fix and
> I think you should not.
>=20
> You can add my tag but the commit log should be rewritten and
> you should add a Link: to the discussion thread.
>=20
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks, Lorenzo! I'll post v2 with the commit message revised.
It's ok to me to have this patch go through the hyperv-next branch
rather than hyperv-fixes.
