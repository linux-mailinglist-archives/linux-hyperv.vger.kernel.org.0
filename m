Return-Path: <linux-hyperv+bounces-3151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2659A27F7
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Oct 2024 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2361A1C21636
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Oct 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513A1DED68;
	Thu, 17 Oct 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gtMErriz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022102.outbound.protection.outlook.com [40.93.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5613B797;
	Thu, 17 Oct 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181222; cv=fail; b=Ueh7YTBb/HkEowv2j++CfeA3eCLuNQj1UO9vIAp5fdPRuDXu9/HLyG1Aux2OcYaPsmKqjMSpKg3nMQgrE4I9vI5fYnQNuTUYlfXgbeJNIq391gefGyLiN0CCxvM2JyCgyr2jPQORE9fZoS5RjzfUG1dcq8/Ji0GfRBTz/Q3yt3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181222; c=relaxed/simple;
	bh=0+XHxkoMmVS/rHkJ3ux+lyT5E0a+FnrBS0rHHJ1l1Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhPlj21rxYdNJfJLRcNqerZ6w+MEChKiyUq95tWKg6yPPwC1ni4rD6ooxBsD77R7fG8nmRFjjUi/PPKMz/8mgnD+FouBWHN8/uqd/NoWLY1XDb427t9jj4V0iD9FeNSxfnE87kNnBRzrOtfrLl762Ab3regZOkY93cwvcjOLzpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gtMErriz; arc=fail smtp.client-ip=40.93.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhmQEFayc6el0Ssc4XqeRXrEdreYBEqnJMTSFr3Hrp4B4W0brmPcITA8P2OjL8iM0iqmubQlh9oRDzCpOo2vpySVFa5/BkKX0q1CWwYdcN9IU2nsTiK/r5iPrbaCTJI/pdqD1H/Aep/wZ1nud+cD4pfhQiZQXXzRKSLneJAYDKl771AakjGXoRPqGRIqJZ6fVEUxrcI2277SEVOhjGBFEfNRb3VqjpidtLlwyzmLvXdEwBS21P6hWoCyVuksutmF2O+A8Smx5qrIcYFR28Xgsu6UI16xMiVLFPiIYKqZS6T0a8/Fo1Hs+LRrDJA60kN/zx9HnQpI2Csacarse8ed7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7Z03+aD63JYRGZMo0p88/lhxyEIyGk/37vLV+nYUFA=;
 b=dNyFZMmkn8yOb+UOXck0WI5vjYBeyGhHGhztijtXkRbF7qa24qxX1RsGpqPYH5s98+0Eg/jpr/a4TJeoNXbnd2yDi4bEihQWzrU46EEFnZbeNG9zJ7yM/b77POwexTM12A/XghDCCFY0zkHAl+jVwpLr3qjgmXOK0nYZ/fmjuQYsXSdR3H4297nNdFf4Z5XnEyNrL08c1XvbaoIdxpPr1ehLJmFUtNkxAlV5K8DDfEMFdlfna8KtyghlzRdX4PjdPylXuPv68LhVqP+xuLrZwI/yDpd2l1biDyoPj+3SDfJT7Io/yoItSyZC4VVSbqtVOxUnP5WkFUrTgrhRXcKSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Z03+aD63JYRGZMo0p88/lhxyEIyGk/37vLV+nYUFA=;
 b=gtMErriz8+wIhlm42APJed6LtefbVPkEd+R0oRKOhxr0fgoB2XBeliwzMJaRHiew980nN5OeokfQezcN8N2vY8OQZSxgTduCWKzCXNuS318jSQqPSWq67TaG80Fegjw6fIQpkhLP9yd8XS+kgcEOS0FaayKqpgXIRtdlUES5u+I=
Received: from MW4PR21MB1859.namprd21.prod.outlook.com (2603:10b6:303:7f::6)
 by CH3PR21MB4471.namprd21.prod.outlook.com (2603:10b6:610:21a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7; Thu, 17 Oct
 2024 16:06:55 +0000
Received: from MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559]) by MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559%4]) with mapi id 15.20.8093.000; Thu, 17 Oct 2024
 16:06:55 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] hv_netvsc: Fix VF namespace also in synthetic NIC
 NETDEV_REGISTER event
Thread-Topic: [PATCH net,v2] hv_netvsc: Fix VF namespace also in synthetic NIC
 NETDEV_REGISTER event
Thread-Index: AQHbH+JLMJ4jzghu1EqUDt5WATv06LKLFyeAgAAFxbA=
Date: Thu, 17 Oct 2024 16:06:55 +0000
Message-ID:
 <MW4PR21MB1859765F7B3BCEA3989D577DCA472@MW4PR21MB1859.namprd21.prod.outlook.com>
References: <1729093437-28674-1-git-send-email-haiyangz@microsoft.com>
 <20241017154433.GV1697@kernel.org>
In-Reply-To: <20241017154433.GV1697@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c868a48-63fb-46b0-bede-de26ffc86064;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-17T16:05:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1859:EE_|CH3PR21MB4471:EE_
x-ms-office365-filtering-correlation-id: e5b8ce9a-a6ea-46da-c345-08dceec5b878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fm1L0Lw1i+LHQPYXOwQkmxT4KQr9d97YYpHCGoW3ohKLGgSu6wG4Du/M9mDt?=
 =?us-ascii?Q?QHUIJoF1ra/Ev31+ojteSN7Xh6jc2b0vvJpWvwTM/XeAWViEMKPM8lH5uA7M?=
 =?us-ascii?Q?UOksNg2vvwjr1vKQHTF3Ai7qhDDFALpll/+PeKfWdW+qHbXDpK30lswNZ5DH?=
 =?us-ascii?Q?1AbbgamSqLqGm+WA4zxjs0O8DxjqEZchCLZwhHOVMByermhUnNfjaY+YWrH/?=
 =?us-ascii?Q?nn2eSF3rbyiKmLBReX7aYwjHuTJMvEx7BCHkYg1H5pvv5MAXMRshBw8/jXHM?=
 =?us-ascii?Q?Jak/uMBxnwT1ndjeXm9Y2lm1VHOQXx4wWOb2kJFxmbFez3E9jfpOWClLBNZI?=
 =?us-ascii?Q?cxi4euDnoLH97aOl5Gi/JW816X/nQrjyFzkCq7Fr8cpC6+sBRcJyKA46hUr2?=
 =?us-ascii?Q?NFIRG/z9FM1Ba5i0DQMToJFTbF+IAWlsv59oqE+l6M+BSXcBMXWbylaRgLgY?=
 =?us-ascii?Q?EFzRzfbRkfOrzPXMnuZq0IzQGFcf3NeH6rS+Z5vtTYDUhX1saenF1NsHsffR?=
 =?us-ascii?Q?e59qZRjzbYJAqEhNMeex3NuMR3zJmq47JjjG7OQ0f1cS+yon5bnC+p5r+ZB3?=
 =?us-ascii?Q?UuJ4yjLezlLHdNfX6On5zfQhWBpzvU3/yC9+Llc3/UeCQ2P3drv2B50iv4BE?=
 =?us-ascii?Q?DLRaeGPuxoMnF656GNY4L31huWfHS4GQSIrPZN1GP5O7ujehir0Ci4J78CIR?=
 =?us-ascii?Q?B4uRaNjKV+iKxpYt7fLMUu1TdwOJg5lwUVA9JU7EqILd93QNXxgBi1g02W6n?=
 =?us-ascii?Q?j5FOHtKFAX67d/TruLXIWNVaDMLXbLmQHylX8riFY/D83qNcMQ8qXH944/hB?=
 =?us-ascii?Q?IZAWHO3nQkFXBpPt2NThtnrP57wqlNxmUID1tZ6yjFtXUkWqOw0laYVCJ0Is?=
 =?us-ascii?Q?NHICPTX493GzUeLWpSG4bA1qSYpFlcOmfuwGVlwWWi1MefXYiZOZc1RizJNZ?=
 =?us-ascii?Q?orF8uG57EGJ6fyNQ5J88MXCaMZL2Lh6UbRNljI8rO9eQ0BKpNKj6XO+mE93P?=
 =?us-ascii?Q?z0oMwdBDdDNsDiBGNl0Bpq67Fvh9Erfx6FYF34K38OjSMoQccQAaHe8dgUSH?=
 =?us-ascii?Q?unNPMcdmONHLbFfAF3WuOnN7lPINIur63qOFuUwsYGC3GFpEmaRlMLg7DX0f?=
 =?us-ascii?Q?6Izl7+AiwcLcxsIUYBD94ud5x8sR21O0aNV33estQj8inCosQEROX0KJDhS5?=
 =?us-ascii?Q?H2sLR9CJJSEJPFq3/k8IzO+LR8yODvoCT5kZAlcfXww29AXe0+lvDP65ZQ/A?=
 =?us-ascii?Q?zuHrJSzhMbopzvQSEADj8QnAcFS9bmn0V8qZ4QSDbwNTeRQyiDs4WzDudJtl?=
 =?us-ascii?Q?/rGNSWO/+kz6jR8TuiVug3z9kwZcsDtK6tcKhKElNALzWoEma8TXi5wPryn4?=
 =?us-ascii?Q?2y207cg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lraJS95VTBvsfDXpP1yVWf/CFslUuTrQemDYlwe2e12nJQayl4YPgUikNcze?=
 =?us-ascii?Q?3QaVO4sdyS3D5LT5N9+cde2Ix0diUmXAuakfjKDn4D80041IVHrV2bjkb8M1?=
 =?us-ascii?Q?3Po3m/JAWeWGeOCXyosr6vkHmVym2JP92WmLio57cfoR4hHksYZrsrSew1cU?=
 =?us-ascii?Q?MGtyaXj/Ll7+kcnpuYmgDplTR2GxFaIVkF1gqYMJps7D9ZmEL8qJIUnLCwHe?=
 =?us-ascii?Q?q89zmaLKzCfqMaCKGxOVFaWC6ugArN9/wTP5G8/K5nZ3gtRFfNCq8d/M6iCy?=
 =?us-ascii?Q?mkljl83Y1OPlWXyPJTF6Ph0fl5sWXpUUgYfS09Wif/9psoXe3ypeK5AJAJ4O?=
 =?us-ascii?Q?DnRfUKV1YVDtkL4MLOW5tX98exs9Yw0LgJ3okcBwuXNT6zViJfltrehVYKki?=
 =?us-ascii?Q?PQs0zFejXjRfn0Rn0d1aQx8RO/6KpfAaEMmbpi76M/LTpBdCYnfcJId44r3g?=
 =?us-ascii?Q?LS5Bdi9vW+3rakjKRxOufYk5rJojUvAUNTuU4vagPqS3c+wnrUe6ADvoNJwz?=
 =?us-ascii?Q?/Y1LZKiKlajL3x5t56TqWwrIwbazh0MppqfInpaxTM7cyum2GFrbDgRXP4Gu?=
 =?us-ascii?Q?4248nuvWRVVpXwHDDY7kYTysczZ5OV1CoYTLQ1xNTD+kjdQQkKvEYgBZpul5?=
 =?us-ascii?Q?dZr0fDCvqQor3PApx4TB9lLoKPFsXvX5jtCrW+CjEf4dkAE96Smz2sF17ysU?=
 =?us-ascii?Q?CnoCsAMleHvcLMReFNwg4+Lb0T5Q14RN2Dh+2AdGPCvjSNHEcG5Lvuc9J7cb?=
 =?us-ascii?Q?hzDQuuYK+/VDtp3tCBRNVGCRJmE6nO073ZHgXW0f9hvNsmUDcMeZwk8DOBuG?=
 =?us-ascii?Q?b80cfU2L+cpXBoSwdGcBnAlVHGn2p6hZnFkwtvJaRK5HTrElMqXUCykUfe+5?=
 =?us-ascii?Q?Wifj+z7vFL4vfQMP980PRi+lTrFGxllByOVEBKLKB3CkmSDeyskYjl8PXQNT?=
 =?us-ascii?Q?whnLnvdcGr2soH5/tKahOM7518T4Sb5GzZvnajd9INA+DmPBdwugpgseZMSp?=
 =?us-ascii?Q?3nTqG7jIY2C7XGduyd3C5dd//aDSekcRuhr8kU5R/m4Ni4xZKu2JSFRvRHwJ?=
 =?us-ascii?Q?MrvWQnm0AOgLQYIAngieRnZnicYS3+v3Jbm47QbOHl7MQFplOhML1tmi9iZl?=
 =?us-ascii?Q?T2rwVRn7rWtQineINxPegnYcPkrLIXzkMzKNfF55KprKpcQKTOvJF8JeHM5g?=
 =?us-ascii?Q?SJNUh0f6vsk4u6Y8rHOqyMLBvOCyjO6mJ537a1KsTQjUrxs7u71sG4YQo5P6?=
 =?us-ascii?Q?nLASrOH0GaZU242VlXjrLI1LzyOJ1OtmmA1+ZDeXaezHIyRwtWnSxUfaS6Rg?=
 =?us-ascii?Q?8dO0zQpOjzikeYaPJM3yTPzIkMmG1NieOB77iw72fAnazynxPz/b8dZZwEYJ?=
 =?us-ascii?Q?9wz3zILdGeS0K17qcBP+e9rr3+oB6XchY+sRYsvuN/lTX1d8TBTGWeBlNix0?=
 =?us-ascii?Q?2fwtBI6HQovy1mwJosF0pgbFzF1LVmKnTas/qexfX7s52nZYTuuKk8h68fN+?=
 =?us-ascii?Q?Kl9RgQFq7zV0vmQgqxiTaLMridlQE5dR6Sf2ccZQv37JWQubDbLfWMeNaLgG?=
 =?us-ascii?Q?YTBwv+IiaaS3VNLBrZ7aG/xfb6lc3qa+XrYS/hmq?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1859.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b8ce9a-a6ea-46da-c345-08dceec5b878
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 16:06:55.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7RmU+0atJ16tH8TGEeDSOWlegc5Pa4ay502ZcF0k9YWKbzlAXTsmxCw1vdNce1fN+/CqXrp7DEP0RAk6dk1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4471



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, October 17, 2024 11:45 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>=
;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> stephen@networkplumber.org; davem@davemloft.net; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net,v2] hv_netvsc: Fix VF namespace also in synthetic
> NIC NETDEV_REGISTER event
>=20
> On Wed, Oct 16, 2024 at 08:43:57AM -0700, Haiyang Zhang wrote:
> > The existing code moves VF to the same namespace as the synthetic NIC
> > during netvsc_register_vf(). But, if the synthetic device is moved to a
> > new namespace after the VF registration, the VF won't be moved together=
.
> >
> > To make the behavior more consistent, add a namespace check for
> synthetic
> > NIC's NETDEV_REGISTER event (generated during its move), and move the V=
F
> > if it is not in the same namespace.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc
> device")
> > Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > v2: Move my fix to synthetic NIC's NETDEV_REGISTER event as suggested b=
y
> Stephen.
> >
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> > index 153b97f8ec0d..54e98356ee93 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2798,6 +2798,30 @@ static struct  hv_driver netvsc_drv =3D {
> >  	},
> >  };
> >
> > +/* Set VF's namespace same as the synthetic NIC */
> > +static void netvsc_event_set_vf_ns(struct net_device *ndev)
> > +{
> > +	struct net_device_context *ndev_ctx =3D netdev_priv(ndev);
> > +	struct net_device *vf_netdev =3D rtnl_dereference(ndev_ctx-
> >vf_netdev);
> > +	int ret;
>=20
> In Networking code it is preferred to arrange local variables in reverse
> xmas tree order - longest line to shortest.
>=20
> I believe that could be achieved as follows (completely untested!):
>=20
> 	struct net_device_context *ndev_ctx =3D netdev_priv(ndev);
> 	struct net_device *vf_netdev;
> 	int ret;
>=20
> 	vf_netdev =3D rtnl_dereference(ndev_ctx->vf_netdev);
> 	if (!vf_netdev)
> 		return;
>=20
> With that addressed please feel free to add:
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Sure, I will update them to RCT order.

Thanks,
- Haiyang

