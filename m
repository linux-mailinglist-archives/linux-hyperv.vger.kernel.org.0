Return-Path: <linux-hyperv+bounces-11312-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJQPF1CAGGpBkggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11312-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 19:50:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAFE5F5E66
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 19:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 735A03191CBB
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660693E0758;
	Thu, 28 May 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZGZtqspY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023106.outbound.protection.outlook.com [40.93.201.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F24277007;
	Thu, 28 May 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987177; cv=fail; b=Q8s2+HwN0fiIDFFhFODFp9wbmZdIGzD/lk38HnmkwBwofEEAQCDuyFc47mPkVqnxozjEb3o+SeFp1hT9v6hJ2OXlsXmNl7SL3Q3MtZlQilZE0GWrEdAKYRSYUs2cVP5pn49cnhA279TSrN6pEEETnOrIXILa7XUKfAMUyFHEo5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987177; c=relaxed/simple;
	bh=P+KzvKqLaCpoGNO1X3XDm3k5dhZc+D4r2bCs+fwoC9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mx1TlN5wsQQ2Mt6MutvlGz0XXVEwNOdW+iWZOj0kAjbBkXFtETAjzEya2AFxFUOtvXILaI29cvgjuWu9112mNoW2kjCIShTwlXQBbmYC9LrL5267Nc+WasA4RPpYzes7gS6z91B39e0QW6A+Ra6OjRK4emCLlDKTow5po6uBBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZGZtqspY; arc=fail smtp.client-ip=40.93.201.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1lXmwFQ4A7hiLeLgyG5gPVjgUPMJGe33eGkg1aIGAIacSJre8/G2n3O70IRx3H8MifxdiII872zLLHBusWm/95dZhPr/yXsaAEHDUNf9eGKS73DnNZBxvr8p93z5LtRRYUk1aQstCGJXnTlZeg/v0DsobjPMGXDngXUUkPUURJhsPk3J5hs1zF13DxiIM9Vy3NefX6m99/q2XURK+frAUimz3YoQhUWfTgpstqi3VPXBnETmp5MgAZfujp9yO9xw+EzGV4GrkGarb7mLpeGmQailvs8JUsTZbfwbX00rwBcMm1o7VeL8W6+Y2Z/K4HwC+JZb2q1dKklemNilzzxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb2HOeUxZSVKa0+OkEgDLOhDCUO0VeC+X2xko/UNsyU=;
 b=wj//FSNcN0jCsKDYmgOb521RhiLCLeQvqg6ySK9Enqzlh6EYr1C0tgp1lCASZz1CTicpLem37RiBYQT8X7MENCS8KfhzC6X9ct1lYwsVBb3fCZLToGaOO8rk5p4UBxF2J1jbf6DThPZJJ4RjOSlYZhMVS+Km4IXVuYRXgh95P4hj3MW8MdQSwTazFsvsenboYoYTV1RqEp05fhN5WBkqfDyEsHMI/GDuIerWIhu5409moSD+9AsU2D5WpXu6vTsbwu6vIqw2Kav/etrtK6Ygb/j4jmom1eYY2HUbEeaOMuvPocOfAdzG+BnaQpxhZPAJh5660F7OzVnooHPWX4Ifeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb2HOeUxZSVKa0+OkEgDLOhDCUO0VeC+X2xko/UNsyU=;
 b=ZGZtqspYEhX+a5HU8grie1S4v2DuF0EfeLXltzuhAkxDgFlFg+aEglO+enp6QMJdj5c105mdzCkpQxvX716YkVVHRK1gHdVYh7H4du7MLFXuI86Fan3sZkV7Gnsr4teL2Lop8QxAIc1perxPh0xA3fgFtmklyJGkm/kS1c9SfDE=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by LV5PR21MB4729.namprd21.prod.outlook.com (2603:10b6:408:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.3; Thu, 28 May 2026
 16:52:53 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::648e:8c2b:b5e4:aefc]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::648e:8c2b:b5e4:aefc%5]) with mapi id 15.21.0092.000; Thu, 28 May 2026
 16:52:53 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2 1/1] drm/hyperv: Replace "hyperv_" with
 "hv_drm_" as symbol name prefix
Thread-Topic: [EXTERNAL] [PATCH v2 1/1] drm/hyperv: Replace "hyperv_" with
 "hv_drm_" as symbol name prefix
Thread-Index: AQHc7qkcrZ369g+21UStSntAJBmfxbYjpcgg
Date: Thu, 28 May 2026 16:52:53 +0000
Message-ID:
 <SA1PR21MB6921E2BE7D0F3B804877427CBF092@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260528135108.1787-1-mhklkml@zohomail.com>
In-Reply-To: <20260528135108.1787-1-mhklkml@zohomail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=321657cf-567b-4be5-b1e9-c48497ff415e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-28T16:46:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|LV5PR21MB4729:EE_
x-ms-office365-filtering-correlation-id: a33dccef-e643-410e-9441-08debcd98f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info:
 Eowv2wgmDjf5W1VJtcjk6U0yiFS+I6RwDX7glVWU/JKy25OcjNfhhDPVZhvoUcGfpy2qwQy/b6N/8SonXfsth8CjO02TMIAwBw2wA9YiAd9IpDQ/LZKBPbtAV1IlefW3aRRqK/sV75/Axv7i099bUnTW88D1rJzFtK5+TQKdMGda6JbVpC8CQPzBAWK0pbZDvxPkSWneOV5p+e8hMDD2f3320b0DmvWc3j/brTa3o37nunInrgpHcs+sMA6bLWSu6vlhrokfU5gO+klTnlhxY5bUJTe0PIdB24qUtQ1vBFQ5B87FsE7j5lPbM+ZG2hUKIW81qEtfaAPQGz2yx5aHx29OLyx1FVtFwcpm1O+/oWOc8lqXzeYvZONaDHcKjbBP9kL3xbd8dYJ6UuMWNj5yDZA3h/uPaNcdxO7reONZ6xXfjxvhSZqKbYyxK4sa1IxfeLJI8oVjRAOvapnyedMVxX+s0SzIuPF/tvGX8S5ElINXOTFUhg5LkZ29sRaLjun5CKxM7MBZPDGX8s3JtVPyy1S+QUYKLCOh94xC5e0sBrlOSyjvryDDqNbSToYWs2EwXVYoC8J84qLfm0rQYXIb1lpI3MxmSh0/oPMZ9KAtq8aw3GhYlUqqdTatEtz5uElgSMD3UiigKeEt5bOMo7C+6gYrKh5fUiTFcWifB7mDv8jl+9xBmgM3r8q8FLyeDMBKAkgJ1xmN8hPjfGxk/THxzXrIGrv7SEMBz8OjlQIdWTh6QpQponLIgSCBncQuEKPi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c67oHp3jKoQGvgTjDTHDaRTKg0Sv5WaLui/AwrnRlWd0azsEgljzBSFKXvDI?=
 =?us-ascii?Q?/BQlIuvQDD8WJaacbZBDYIM/OdkjFnylmGJTDDPBUyYop7y8Sqv2NlbST6hw?=
 =?us-ascii?Q?eLeu8lZ5z2Z/OZiONZclVur5naA4SmXj5y+KrWtbG7rApSBV0LSQRCY8+L5a?=
 =?us-ascii?Q?nKJb5A4tXzkssMzl3S0X0oGI5ZIuaGgBOo3z/kV8b5rEspQtfhA/2+PG/cLu?=
 =?us-ascii?Q?IDAflbx7xKT/ViZ8RXzxMzHrvVKm6dsQfzxa6MLEbsXHU6xkW/8KykOBU/kH?=
 =?us-ascii?Q?8NWImKntcpZ5msV+bcJskDuB4dU5RQQSWRrIJHa1jCqQeGnPxkC91QummXpg?=
 =?us-ascii?Q?3gD0YdzP3d61WYHou4CXH4BTjQWlRKj4CJoNS4jQhrE6I8iixMvUQsOTWrfU?=
 =?us-ascii?Q?NNgIyt/a/EQMNiDY+JvPreZkF4MvAKEWAl0/Cr6mbNzyfGHoNNAVuimCkhJj?=
 =?us-ascii?Q?cmupMHmMG6Bddo61EjYDJZnlRnp2H7/8DkSyGozgCedPouCeuz/kTMgIRsJ3?=
 =?us-ascii?Q?c6QkINnnK1sq7DA3zfFxzejeKBIM/kr9ifr3xy53K5lNrAjh/CVb8O8VZQoX?=
 =?us-ascii?Q?sVJ+ulZh1KnY/kJ39NIhiczEQ8IyJ39Wb8bTlaKpMjPEbyx6VE1wbfO36zyx?=
 =?us-ascii?Q?7Vkf9VMfj3dDsQrdLF91eZf+jcA6PnJdgQe/rVjpbxfwTjY+ApXzIFlu2red?=
 =?us-ascii?Q?uwLaOd60Cdypn9GIpxDgQzm408la6lgK686cntj4MqEtqm2uWkRxIrp9srrC?=
 =?us-ascii?Q?X9605FnlKKIoKngk6+WroFFIH0yg9FnqZqIVh6GN7PmPRdpCLlaW/b3eEqpu?=
 =?us-ascii?Q?CwIg0lzMBwn2ugGPO2WyHk7jp7t+5q5QhwVb9ZAgZmLF8p89mCt6aZ3U60Tg?=
 =?us-ascii?Q?zih3etlsy8tAjKn65OaPrqLQokMcCYRH4DuMyfT2uIDX/fsGQhAMPk5a5/ML?=
 =?us-ascii?Q?fLP9Df0FVrmWpMosNSlFugW7iTjqAm2++Z08arql/estSc9q4pgBj2FGLRKZ?=
 =?us-ascii?Q?zDSAZbv5l+ANOCw8JEy216RCteIctoLO2NAun1EzP33J79zWdmd+3L4cpE1m?=
 =?us-ascii?Q?YgTyKNmbGqluXYvthkQbi+CfaYdcyrHB7ElWmX7MnmggHvR1QHbgodLqJ47x?=
 =?us-ascii?Q?yAX+eno8v3dmEOHkjqODxhFh6RX2LgVmRAAcnlayM45vbWsEDOKsySGGyv1s?=
 =?us-ascii?Q?xGffOoPs6MH1tb7uMOlXgxLhdELG+pEkXJ19eC/mleZ2BV4J0zTPT4tIepLc?=
 =?us-ascii?Q?6t2ZW618jjT+PCJfqZ2p0yoczpXYLQkgOyeVhE5RVbqUSH0xem1zEwMF+/u2?=
 =?us-ascii?Q?j7Rfd5qZQeBaubLlTyln8+OWMS9n0jbsRym8+xu6c8eYCo/qlXvLPmeS5LWX?=
 =?us-ascii?Q?ZbbD4j83HmXfZwr/EWvLBoEHbs6WQP3Zc3/3+LzJ6AZo5Urq3Unrp+KAR44Q?=
 =?us-ascii?Q?h+cBcweER7HzvUHttKMGL4ak5pH71jkSe88mjK/PqOteAvKlV7+T6tlqjmMs?=
 =?us-ascii?Q?/iTYyW0XNwBDXmNZgXSneAcoC0wLV6Szxpfw5np9UVxvBl5biztema1nOkO/?=
 =?us-ascii?Q?jSavrmKkjz+JMhSJzIsWJ8IpNlE/9CChP75FxMkkgZ0+KPOlPll9z3vtKZaF?=
 =?us-ascii?Q?L1djveRW9tcNP1Net9150NB3pIT3PxuRURz0AgmwXeShNYub7w0uWKJLqyqb?=
 =?us-ascii?Q?yRsE3uTdxxcOlVQRY/f+B4xeG+cDRwr8+ZrBV41jPiWVFn6F?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33dccef-e643-410e-9441-08debcd98f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 16:52:53.2838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/TBFoeXa4vF9i8yClTTWsS7bgXsp/gBfqdBKQc7A/qrgTUdGcbkOfuXYN/FJYydqgd1nYfqf79g74UqAj70Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4729
X-Spamd-Result: default: False [4.34 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:email];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11312-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[microsoft.com:s=selector2];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[microsoft.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zohomail.com:email]
X-Rspamd-Queue-Id: CAAFE5F5E66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklkml@zohomail.com>
> Sent: Thursday, May 28, 2026 6:51 AM
>  ...
> -#define to_hv(_dev) container_of(_dev, struct hyperv_drm_device, dev)
> +#define to_hv(_dev) container_of(_dev, struct hv_drm_device, dev)

A minor nit:  change "to_hv" to "to_hv_drm"? Otherwise, LGTM.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

