Return-Path: <linux-hyperv+bounces-10138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DnmINkw3Wn1aQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10138-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 20:07:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE96B3F1D06
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B07300B110
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE83E1D1C;
	Mon, 13 Apr 2026 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BBdOnT1M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022089.outbound.protection.outlook.com [52.101.48.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A403E1D07;
	Mon, 13 Apr 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103249; cv=fail; b=OwMBO0i5XQDsbfM9eViEKGL7WVdNZX1MoSSgOG8UIQV3KW1YqW5uS6CQpX0UD44+ctGLrLVRD4LCyqcNQN0SZcwfS59hpa0qGy+t8bmid3lvp66rSTEqBnFzcjFrXd1KdNw7mDCiwaTvGy41dfF8sgKzQ+XJnxGJ9oB68/QTK7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103249; c=relaxed/simple;
	bh=pBtfl2zefEJCkUYF9uPIrzezM491W/tMsPR6urlmikg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pwRyjPHgBxvN6ZOUunuCjvc4OA37ZfeYF4fXQ78MMYfWUKXiYXddET8WBUAwpyejmYyptlSfwDwO+yFBjQHPqQ2Txofn4PI5DxsmuIxUBI1a2P7L3J+SA96JgD9zv5sxxBSfLSntCO4atQUhqduL32jycNzVs3CMxDpVL/TS6QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BBdOnT1M; arc=fail smtp.client-ip=52.101.48.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZ2TuDne4U3HYprKrQhp1BsBjnaof3edFQP0N4I/5TgZKYXecxR/hqqoe1mOlkQYy6KTfOZxRLc8izukNcFQH7VBb6XF/MA+AdCpCB48dj1pPS54o2QbPKzUQwoIIyxJf39uUWQnculep8A0hq4BeCkz1tz20GpiRZAa05ezMYh6IbTUj+vTFhA4t1Xq3Gll0CmVEOGXr1tR4r0FczV/vjtTJOWfIG/8HrRjLqpFUZz4gq1+IfMk0H9Bq50qmzSFRTLNhok6REHJlTXmaWvF33i91iRUh0Jjq8YF/XM2AHgf5N56UZIX5yd7V/mzZ07/xA77IUIltrVj5sWadEY3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBtfl2zefEJCkUYF9uPIrzezM491W/tMsPR6urlmikg=;
 b=nqmhpJI0eU4BdWiKCwTLhynfAXIF7csqef4GF0bq9dOAhuN45SLJ2wWrmYnxtfy2pEot3KM5QnP9OAOhPl2YxcSGzfl7JH46uhGCrJ6i1atclgE54xdmgs9RvYx1XuTkLJlVZsfiQ86L3WXvV4pYYTe7eA/S5mfNftndupVsNt8NAV30XkMNigslomeKoDT10UNGed7Xpe3jUzH2WZPy0SjV3t5Jc37T3zmzTs0d7V2SGWx7IjG6+kgL4u/cErWnKhZs1X/QAd/uxbP/C+a1BI/yQ/7SwVP1mfQ8pKBztCreiDuB/xE86y/C6FvqqqlpYCaX260Iaqxh1SIcj+ItUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBtfl2zefEJCkUYF9uPIrzezM491W/tMsPR6urlmikg=;
 b=BBdOnT1MmdngrNlw91N3zqQIzlOCLBFDU0MwEDoSIWG858eRTSpy5Ojs0Nm/dZWNR/UxEq5/6riuRWJOU3ri26sVnhFKbWlcJkBeHR3wfJj0euMfmieptwOrVWnVj1EPoUEKcvEWqHZPeCn7y93e7qjXSpkJnVroCRIqGA8Si4A=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5678.namprd21.prod.outlook.com (2603:10b6:806:49a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 18:00:44 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 18:00:44 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Index:
 AQHcskxp/rldcz8WSE6y5yrJ7Ov/rrWxl2eAgAAP7gCAANlFAIAFtXdAgCBm4YCAAHC7cIAEJXUAgABHFvA=
Date: Mon, 13 Apr 2026 18:00:44 +0000
Message-ID:
 <SA1PR21MB6683609E2E86D0464697F4DCCE242@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
 <20260413134602.GL3694781@ziepe.ca>
In-Reply-To: <20260413134602.GL3694781@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9cde75c9-a55b-48b8-83a9-76b1640c171d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-13T18:00:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5678:EE_
x-ms-office365-filtering-correlation-id: d525dc00-5720-4095-cf47-08de9986958b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 dJ4fb+0BtU9RnXkvT35M5b6QKmmrpefR6xZqFj2Fw5RU+dpW1v8LIrTmc2VZuW31x5K2zc0QNn8itwCakXkVfxCehzv04RJLMl/J+DJgu15hCnUltmPuWqO5EAn9rtBecQDdrcXPRYA/8cPUwKqmgS2x4dL+bQ9VWrA3que0LAuo+yiJGFhwjOK+J/xFadbrFWAJJMxAdGWszRIWJsOHXBVZ6bTsE7XbsyUrsiPDYFLphP4gFe3HA7e2Uw2OT4Xr2Qs6N/APOuy+fS+Gjvrezw7lR+MPu0W8YMfYkMWip6qpKKhq7zJXUzhbQuAc6TvlaIYgJL21w/MEkPnLUd722mHIZzGVtGdMtLRvEt332zvK/14b/wHAkZ7Er1VrS73b+nLYiAIpI4jwe78v+zYfRiI2DuVF1dbVl3pIz7zKK0yLh5HD4aFiNaTOkLvNO+yW7QJaTGBk1+nkXgkZbPB/A69Vmo/3LmOjZjvPsUnazxdhq5hy1ArkHHU/zXzNPcd0GcjHBIiBFyGHk27R/rWBNWgusP/RNbW1olJ9zN9ekYqJNXzrczFE2EQuZmykhXEr35wsPj4Y5AuA7b3BzwP4w/3lFfCZDLRbM1ENNU6OW1klhX0SH5I4a+Dbx96YzacqJGcuWmMgvOTUnndn4vhYtgo3x6kOwYIRrHOkvVijXvWy2Tq2zJDuphoK3NgvYndq38ZNmhF4PuGyzzmywWiwkm+1Tn6LKrzuAzoNSwcKPPU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H+7NAGzHxQSR59sXVHfqIatr0bhOYpX4SJ2bysHvlfcWOVfE4o3tjJ0b7Bab?=
 =?us-ascii?Q?PaSXRlH3GOvIXVGtFwChqW0zE2ynJijt+ngT8t/iXtsVDHs4OMWwgqBPbu2K?=
 =?us-ascii?Q?fhOKorZitKYp1Ha+S6RoEsKjB8B3DgBV5EMLzv0s8rBSKLpVhAsRUwLhiDZI?=
 =?us-ascii?Q?Z4IBWZZpE89XiURf9kPPZupF4he0mtiMEiq/i7RT83m/8CIsiBO8oiR+WqCR?=
 =?us-ascii?Q?EDwb0FwGRUitthmXZ94tvLDEnLhQQRr9Qh1OakDg9bXFEsccSTZwIoK+Hlaj?=
 =?us-ascii?Q?gDPA7v29WqSP+t8SMzFAUEvuk2bOTNzhmItWNLruTadly9DEgdzJc/ueiM87?=
 =?us-ascii?Q?IYbo0urshlYX/Er9+tb5YQ+OooQuAVxH1MNEy8Sbqf6tyCvtLsL7Kp3ToR5I?=
 =?us-ascii?Q?nXzFa+tjgeuVrTQ9eUskv4yEhSolp55LokbptZBSu/GN/gD67UiLe3yleBjZ?=
 =?us-ascii?Q?+cy4LgTLBKwtsWanyJuWChaaJuxZRzF/0zRGh4O+sIbXO8g/nANsZBB5u4dJ?=
 =?us-ascii?Q?/TWmKghT+eUUPpuLWeQskUDnUigiuIa12aNz7r9q+F1muYHIb3A29mWotqHK?=
 =?us-ascii?Q?RiGbAfCkEScSvt7FFTIVHDediBFWdJOvhRa44tLo1zxhpCYxwReQaEOFliV+?=
 =?us-ascii?Q?w6mtgMDtct1sN4csdPuCEszMvMXnps/nXKErA8P3acH1A0WysqISJNYDXqru?=
 =?us-ascii?Q?6qvrHInD8rzE6FoJNo0H7e2lCZzwYiUYirDy0GXIlyjkfwMOW5KzJ1YW0cn/?=
 =?us-ascii?Q?IC7QVXPuBsij5i3egvzeu2BokNe/To1ebqvXp6jdQnxmAVfeLCkCRIJJ9yJC?=
 =?us-ascii?Q?MvrnOdhyfFgikriAZklAxHoTqkvCFXCZauc/AFyyIZ+wLxERtc3HDZX3QAbu?=
 =?us-ascii?Q?rlFyPkeCry5ibGYVgXeAZcD9M2HsEZygOZrF3XXzj2h2XhH1VkRBEqr7jlhO?=
 =?us-ascii?Q?DNXOiIs0sMo1Rx9oD1YNzzxUcej9/QG21hEfidOTyggfpY49p55kO5E5eoI1?=
 =?us-ascii?Q?RaSCAfUy1Cp+tk+g6irng2pl8G/k1UZbAuodg7rkTO1u95S+j3pUoGidqpQY?=
 =?us-ascii?Q?/bGeEG7rugEG9MulIzX9oK5kQo96DQOHPYipbW0AVxECuIxNiAznIkR/D52e?=
 =?us-ascii?Q?uLdgq3xycjIcfHs0tjHrKKDaiCQWB2RPMhnjl2Va/BHLD+Hz2liBuRnS5p7k?=
 =?us-ascii?Q?komZPJbvmx1AbEAm6Ag7fHge3CTkTcp9pSRc0mJJRXu3lNIxXmnm6zKvSjRd?=
 =?us-ascii?Q?YUrcHvadNWzefp0TeCLYtAzrmSN1D2ak/XqSIl2m9N/eqiONuUumHeVSrt20?=
 =?us-ascii?Q?JZNrSdIOZ5AKR5kgYQJeVrNIeFEE4bnBieKHr7GDRz7IWJ6oT7ZYLOv0qfcv?=
 =?us-ascii?Q?xvDLqyLOq9lvFbAMRjOrbdg+s1+IQUyOlh1CupEGh4muG5Rpbh8Z0ArEwB6b?=
 =?us-ascii?Q?Xn1rVDQHbW+V/a0P5v28HBwAhDgogeWBbb8eQ5ETvsq1F4Ckv1Deul13le6D?=
 =?us-ascii?Q?I9qyCEaCp6WV4eb1PDXvrbFuHrPJbxrxSY+5je0izGuMfcU4/QBnWwjrSKjj?=
 =?us-ascii?Q?Rp5KLRgrMnMTZzVUsHz2DRyw8/jCavbm2ZiIrialOtx8Nv1eBrf1pPty6Aqi?=
 =?us-ascii?Q?9RWR7Bs9YXlx6qIw/wOWKfCmupfOddhhPKE8erUjEPDrhvr7UX/ETfA1txOA?=
 =?us-ascii?Q?SKU0y78UQntS5Sx0hGVZ52IHDnP1AzTePvmkGDojty3yUcrw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d525dc00-5720-4095-cf47-08de9986958b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 18:00:44.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGNCmUv9dJsS3ki8qeotNvYKxgn6qnfS+UIzAxWp6ei/WBtDchuhDSIBc6lLis3pR/UkOiO/W0szHNUd6eVi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5678
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10138-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE96B3F1D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Apr 10, 2026 at 10:29:45PM +0000, Long Li wrote:
> > > On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:
> > >
> > > > How we rephrase this in this way: the driver should not corrupt or
> > > > overflow other parts of the kernel if its device is misbehaving
> > > > (or has a bug).
> > >
> > > If we are going to do this CC hardening stuff I think I want to see
> > > a more comphrensive approach, like if we detect an attack then the
> > > kernel instantly crashes or something. Or at least an approach in
> > > general agreed to by the CC and kernel community.
> > >
> > > Igoring the issue and continuing seems just wrong.
> > >
> > > This sprinkling of random checks in this series doesn't feel
> > > comprehensive or cohesive to me.
> > >
> > > Jason
> >
> > Can we follow the virtio BAD_RING()/vq->broken pattern in
> >
> https://git.kernel/
> .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2
> Fdrivers%2Fvirtio%2Fvirtio_ring.c%23n57&data=3D05%7C02%7Clongli%40microso=
ft
> .com%7C698adb98daa64e20184708de996302b5%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C639116847704528406%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoi
> TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DHkjUfCDysbQKTuiCsiQai
> gySStd%2BI3VrHUnfMC%2FBORc%3D&reserved=3D0.
> >
> > Add a broken flag to mana_ib_dev. When any hardware response contains
> > out-of-range values, mark the device broken and fail the operation -
> > during probe this prevents device registration entirely, at runtime
> > all subsequent operations return -EIO.
>
> If that's the plan I would think it should be struct device based, but ye=
ah, I'm
> more comfortable with this sort of direction as a CC hardening plan.
>
> Jason

Will do, thank you.

Long

