Return-Path: <linux-hyperv+bounces-8930-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFm/KICWmGlaJwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8930-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 18:14:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9A169A33
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA76301700F
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704523090DE;
	Fri, 20 Feb 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IzsVmnzl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010003.outbound.protection.outlook.com [52.103.13.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B501A9F90;
	Fri, 20 Feb 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607669; cv=fail; b=ac5uELjjq2jNm0Q1sJCVnK5KUl/nLNz9z9645+P8CZkD64vsRQ/wqQGWQkRHXyo8SaHd0q1khwaibLZ6oxgSZSriuHtb+a1qbOIDhccaIfo40cCf38JdxXVivusXBMJ4zrtyeS8C8L7t3xpEKhlvkohPSYaKYlsSzKG4U4gbMq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607669; c=relaxed/simple;
	bh=0BLOf2jGJocKX3VACF8Rg5pjtoNOrtQssKgPabCE3VA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XO2KyLHGRWItTgQB+pm5mtMYv8LC1Kx0qLm5BljXmIOFjnrraLxWeu/kZ9/WKDnyk02BAcbdBcQZqHJZx7N7A71N5g0QaxwuoUil1azJVDj2sRFSQ8bIeJ5xvFWPy68U5QxTPHBc+HWFhzSs4IWqFC7JOkx3wy67paEKJaF5O0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IzsVmnzl; arc=fail smtp.client-ip=52.103.13.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwAlpJH9IkJntEyiLxl8KNAIggR/eCQrI2WsI7uqcqLm+ytUNdHlg7Lgq0qHb3HQbFBTQqQox1IAuyFK987/SwnXdJT6aXLA+gmnOpSi21nJpKuIGbuTnx4t86ywoTYLNX8wwRud+R+idUhEsI5rtSRHi1JfSnoGHeuzR69EydBDsugHq+jjt4qm8Vp3g/v2JEkyDoNb8Y54C6UZucsyAF7gIG4b39+jPWlk2QrgbMI0GQlx2C+cODjOQ3SyuJ6oE7LWzgPPoxZFHHIkv4Xd5MbTOSI/qTCz85mxatx6t5FY+hRgopfNDzHdtWDrc7b655kFbQBcupiDFQ+SIY+U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LC6xv27bWnoauQ9QFimn3mpnnoWXJubSs3Uyq49si0=;
 b=Mct+EbJYDzhrO3MTSBcH/AY+1pEmHm3ZRe/+nNwRk3RSoYcoi9n7RahCv22qJ7KoTBXGuHcfu3auPJOEPClEJTVdSTk7mMMdub9rW+wvIY42R0QVlfsclil9DHry+p4P0lzxEyPi6JJrx1zV8P2YDTo6wmM9h0Ww6bA12Fl2H0QpNyADYTHLJdhYeou2IQO/DWyM4XgZ+xCMutH9VyXJmnvQDKodSSU8EpuBjUMQB3F4kx1YDCtnjwLfUeDkPUTIQnhNi8q92QHSL60R8XfJr7iZxyhuFOK3EXCYSFzTuTxBdKI63U90EF4n6GdxF9u5LXCIEImkoeuIx2X92ZbJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LC6xv27bWnoauQ9QFimn3mpnnoWXJubSs3Uyq49si0=;
 b=IzsVmnzlmFBmPkI6zTi5MHKSWI+hsl21EUCvtdIs3lXGVJIZnI9plnctIAiMjvqt986qimibSuC8M8ny8SUoC/EZ0S/bEWesKx4xklIub2AvsWBqGJiInMJU9PKP3v8M7v3eROLnFANmoZJOOK4kuawdN2LdljbD8FIWPdiuL7BkdPNdYxO0jU9sGMzyHo2wPHP+wAngJC4jzLZTMDIhupOlXUDB3s9URRikNyQg6fMcGHa3OlM3AdZBLZyCTtazAbCDyIzczQP4eYdF2VtzMXlgR0wdx22P1Ydg9h84AJozgo5gv6oXl1wHJbgq6+K80C+0I2lhZ8QK1CiOsG+Xzw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8261.namprd02.prod.outlook.com (2603:10b6:8:f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Fri, 20 Feb 2026 17:14:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.013; Fri, 20 Feb 2026
 17:14:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Thread-Topic: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Thread-Index: AQH+hXEAj2Yqm783F8li2oZ4zKzO3rVIDKZw
Date: Fri, 20 Feb 2026 17:14:26 +0000
Message-ID:
 <SN6PR02MB41574BE5CE887CADE406BAD3D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
In-Reply-To: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8261:EE_
x-ms-office365-filtering-correlation-id: ab86dbca-7355-4231-f246-08de70a37fe9
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|13091999003|461199028|41001999006|15080799012|8062599012|19110799012|8060799015|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5TkiPe9kW10zQxbvPv8oudU0NHBbusW+wNGsS8eMEE0K0DmVf3UMBQGBUzaZ?=
 =?us-ascii?Q?M9My+rJlBHIL9XIEWNQyIizi6i2/3pvrTJuQfv6bsMzrZ/P/1DUkKb40J8sr?=
 =?us-ascii?Q?aqB1PlbxEiuOGbFDeXy0N8uiWo2jkDXx0PUrHcjgBrcCAzpoAnBFbJAc7IJr?=
 =?us-ascii?Q?YrCp6GX8a5DtTH0Z3CKBJO3wbSBgPDMPS/3cZrk9iJJ6d9EiMhu5D0M7i1cl?=
 =?us-ascii?Q?FyXo4050tsH5W5BEFt6Yk34a9OhXVwHbPM6OPVDnQMvVVCUxnNyONqlwFqW+?=
 =?us-ascii?Q?1B6ejlg9zvEdVl870MpEDYTrmTpvzNKCx7XhTwibfLpTg5yV3DgVIx5HuEgM?=
 =?us-ascii?Q?76jkpIKfoh7Gjj04tmxwgu9IKIsyWmm6p+/kB3qt8YxnKR3Cc5gRnq9vNIh7?=
 =?us-ascii?Q?5Jc56OzaGJIbd9+iPDxdrYbaoyyp0AerEanq7VeMSsMLEOySlkMqHZwSxvdt?=
 =?us-ascii?Q?iLwL0SNEUXeX4xw6+iencmLu+Anq0n2SBce2uhYPQrQBYtVhMdM/F5qySEvG?=
 =?us-ascii?Q?PayYwf+at7bS/QpWGJyAYV/KdN9wBlt35BlBv8MY7137zcjAaXbcESE427BE?=
 =?us-ascii?Q?eAUw/dMKWct9wGRSx9qbOXAsKXG3XjNkenjGLLhMNK7r8FisxzJJN0n99Kbk?=
 =?us-ascii?Q?1xbDekzOVIs6ejnwACYJ6U8xxlDpoKsDR+FgCx5FRezYwA+7723FipoWJYQG?=
 =?us-ascii?Q?rIJ4NYC6jk7IYUlSehSzv/xTQyCCIFWLh6dmB3rvvVzeSJd/fSh9F98owwYh?=
 =?us-ascii?Q?Gtw3QSYmCVrGZkLfM+A0LCIYc1X++C6D4wE2Quu1kdmBryTtPEwMachJlIcA?=
 =?us-ascii?Q?zPlNJhXk4F/srnb41IJD3tT4ay40GMY177q47Qt6iEqMRsYjgJg/09JiOQGY?=
 =?us-ascii?Q?Hw7WhdXz4qgpFIvB7Qu700GQ+L3etRC9P4uREuK4FTqfAMwA6GNGzyjFqWdm?=
 =?us-ascii?Q?vhrwfsr/TcmQnXzUNR+w/ihVMnRtJ977Zq8A0e71nxhaERxVQvFLx2aF/9Op?=
 =?us-ascii?Q?PiAYZMpQpPIRkGOfh8z/3olrlXviqmOO9b2xi3qzpekSmgQOP5AWqpRWU0YO?=
 =?us-ascii?Q?CQ+kgQDpXia/ij3ZQHTvjA6bBlfoM7rwubuyTOEVaV1m8iVozrwTBYjIn7Z7?=
 =?us-ascii?Q?cUaLmvJufk7eXmMn5luKgdfPZsBvbF28yMExT9HnVVL7VYHr42Ld9/meMOFQ?=
 =?us-ascii?Q?ex15mshZCjJyPF1aSvbtLT/0U3L76k/KUqN2SWaZMHScOLXJ/6w0lBVjJEC+?=
 =?us-ascii?Q?XzQvMykos8atlc6rPnEB?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tk5Wnsj1VdtZ7VY7SpJaW82hOCugizYYT5DUK/iThMpMRVRT3dAdL9gZQL/z?=
 =?us-ascii?Q?BvmA9JMXim0lbflqyFF1DYZsBe7u6YHdDZUISD/rRevwu2tD11LgEf65W7Sa?=
 =?us-ascii?Q?mij49wUysFvnvkbKNnkcxXROlDCZSmsPpIxwdmj+IzkIN3+xPeiVmlroCC9h?=
 =?us-ascii?Q?9AMf5FWiCDI7At8bFG+XdhDpbRocxvh0YIryKEXQVeBYRDIbh/BFlgsLwmDm?=
 =?us-ascii?Q?nen4U/7Vwqhs/SiodRex1hG49McWa906/g7cZANhuvLGiV0ZHXC2ym0px6oN?=
 =?us-ascii?Q?nJBvvH8AFKc/rjL0ebVaggpSsHcFyi7aIW8OEKXU/g8g8th4GWK/4swRQC//?=
 =?us-ascii?Q?nI+0+MSXNqKbGc8JccE/QEuFYvTd9uiBYTip6J9KKB1A3VEDiSwvHft2nMyJ?=
 =?us-ascii?Q?OG0f+BQ+m6A7ZAjmeG3k37F+sLIooLXaYiLrrh4TJZICtuEPLeYUXDX8opp3?=
 =?us-ascii?Q?/ogqzjMe9bXcoW/lMOW7zsugFzAJxFJwcFPFooe3gX/4wDBgbXoxV9BkhNxY?=
 =?us-ascii?Q?9gJzgwvYNwmldGMbCfsJRTk7WuBi63itkOrNi/cdWNTSIcH2lchx3WrBVfW0?=
 =?us-ascii?Q?gSWw11+z/jMhT8cW/XYaRHKdVkUdd8OXhULjvZ+/8cvGsu/EKHaMTdVuFMJn?=
 =?us-ascii?Q?JetfFe2YXHXN1KAFknBgwnRo8Bf1MPHbWotELDQHadbW/ddt8EHBqtZ5f2di?=
 =?us-ascii?Q?7w8o06em5FD56hO7Xl1FuANq3MVd0mCdvbX263uzSAxVJL1q5owI2O36jYos?=
 =?us-ascii?Q?FVRf3IxCCJn/A6Hby8dJvUme8OIrh0ibC+/woPqeF60JW5PdAhbx9TWaVeND?=
 =?us-ascii?Q?uopzyO2z5P7DB9CbxD2PxHc2VRP5qsZQzpMbJWKq8CCDmHvTRBAGztNEOE1A?=
 =?us-ascii?Q?ifDMZJJjnC54VJGPl3OUoKSktXe8TKlHw0MotDXBumSU4B2L+2PvLmANiI85?=
 =?us-ascii?Q?GlXsAHkSHIRiWcTNLWP6+eaW+EStoA67SsNc+tRHjYCJujwRYT3vS5D5zEzV?=
 =?us-ascii?Q?oJl/TG7GXK2LGa0A8AbF5pgTAIB7lX/SF6+BX2jlcQaOnIUOy0jT8e1leSJ6?=
 =?us-ascii?Q?W3LhgkTjj/J7YJfKvBQsNdxcQThDqqgj5tJy2U03SnpdLv9rZb4CV3UtpSRk?=
 =?us-ascii?Q?3LxiUxezkl7XVGQ90RN9qy2NoatLzLk2Q7OmtLu3TZa0QJ1iropNJdyFtpUL?=
 =?us-ascii?Q?F91BLPKKCCU2yujwMn8AFqUFj4EjWSgD3uFQKT6WKHu+dfiIAxZN3mRGBAca?=
 =?us-ascii?Q?mRA+STfNoOB8ViTlOfd9tQegRqkOedD3YzdDEf6Ysm532cvfWOtstZNoIxu1?=
 =?us-ascii?Q?YVgkkraL/0lsWNmvPnjWetJDpQLE57Lh3rDx6vIGXICoavkePly4jDYcuD6k?=
 =?us-ascii?Q?lktvf+0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ab86dbca-7355-4231-f246-08de70a37fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 17:14:26.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8261
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8930-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 00A9A169A33
X-Rspamd-Action: no action

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, February 17, 20=
26 3:12 PM
>=20
> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently=
,
> has an assert intrinsic that uses interrupt vector 0x29 to create an
> exception. This will cause hypervisor to then crash and collect core. As
> such, if this interrupt number is assigned to a device by Linux and the
> device generates it, hypervisor will crash. There are two other such
> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
> Fortunately, the three vectors are part of the kernel driver space and
> that makes it feasible to reserve them early so they are not assigned
> later.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>=20
> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
> v2: replace ifndef with cpu_feature_enabled() (thanks hpa and tglx)
>=20
>  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 579fb2c64cfd..88ca127dc6d4 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -478,6 +478,28 @@ int hv_get_hypervisor_version(union hv_hypervisor_ve=
rsion_info *info)
>  }
>  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>=20
> +/*
> + * Reserve vectors hard coded in the hypervisor. If used outside, the hy=
pervisor
> + * will either crash or hang or attempt to break into debugger.
> + */
> +static void hv_reserve_irq_vectors(void)
> +{
> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		return;
> +
> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +		BUG();
> +
> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR=
,
> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);

I'm a little late to the party here, but I've always seen Intel interrupt v=
ectors
displayed as 2-digit hex numbers. This info message is displaying decimal,
which is atypical and will probably be confusing.

Michael

> +}
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax, eax;
> @@ -510,6 +532,11 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	hv_identify_partition_type();
>=20
> +#ifndef CONFIG_X86_FRED
> +	if (hv_root_partition())
> +		hv_reserve_irq_vectors();
> +#endif	/* CONFIG_X86_FRED */
> +
>  	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>  		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
>=20
> --
> 2.51.2.vfs.0.1
>=20


