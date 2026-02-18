Return-Path: <linux-hyperv+bounces-8878-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFidHWs9lWlpNgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8878-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 05:17:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E41152F42
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 05:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5186E304A557
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B042F39B1;
	Wed, 18 Feb 2026 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aziFVTWS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010074.outbound.protection.outlook.com [52.103.2.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B42F6927;
	Wed, 18 Feb 2026 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388253; cv=fail; b=RlBrr6C9uM2iQlJ+h+OtQkPLkhYCm7tnRsxMjUXSpBg6T64m1tYBGCrkl5TipMZyhKKsgLYAQfZAGayflFQXwVPbIgdEjZhw97ECcKGBLxs8LN0nlJTXS1iFQxj+j7ozZXcBJsU0B61SVLbe7E18L6qBAXNEOEA6K63hMNjxxTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388253; c=relaxed/simple;
	bh=mIitLSP5n/cO+4oKfhqeouGoaSkXkN4aCtXvYGCzypc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOz3tlKSEEHMGb3rx7fmHwP6hBnhDhaxeCLh4j6GlxWCptMwT6pIE5LAh98sXIMCLrOlhEwx9uY35MyYtRhz1m4qTIyYtus55xUsJae3kXGbOc84tHS0XfZ7p5niGbOnPVKJtjW1d5yPZ2drmw8id4yHuBRtzB9WViU1evU1fz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aziFVTWS; arc=fail smtp.client-ip=52.103.2.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5M3YgMKlylaQXHcEUdb4J5NVMqOVwq6AHJvd6v7MaLuRi9ju85jPQDBPGtTJDQjbRb3zP7mNSPe+Pqf4B5He4Elfwut638CFPl1LG2wU8161DgcwnTkLIwMZrorkHv72d40n/MHYjKmFygCAiWhzIYWzjSbm24u5BCJVn/bZKa3y5XA65BYgfdBCi5sAP5aTY8J/EyK1QhHzHju5Y0FFX457JN0qkMrnoWhgNY0TRSdttS0frEVb0SQ4ig9WZ9O3oe5SQzAivzGrWkVbbXPysCJnWvS1t9S/pFwYT9HsO1vw94hhHRQegpA0Jtk1R5yt7emAefXvCs6XZID2yHjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gQVXldfqy68AoeK2mkPc8dLhU9a9U2zxhOOQYh63dU=;
 b=fJEUYlan+DxhrLwVf2WAw7R005F34EXJMVDr+U29PY73m1TJD1CQjpIAsEkU4wo5fymomcS9UYlPPZkZdBdbDhgtLGERBtrBP8RbKHZ47z8u+5v4CpzGKteOKXZSDXeq/jn7YXgJFQnf1NsnyeQpoI253vMG29+/yfsBcjXrXAAw1b4oV+9rA1dIIFEheTVCucu1ylxtxFwNsKY7LC14QmG/BH3DpTqV3ygaR9har85Y2IFBacZwf6vXzS/ncFqXUqnT6Q8mS85Hn/0aJzB9raCaUB1zP80BP4QQRaNnRF9jpOmS9dWsbY0rUpIHks0WZxvHVatoQFBY1zHIQEKdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gQVXldfqy68AoeK2mkPc8dLhU9a9U2zxhOOQYh63dU=;
 b=aziFVTWSJmDx7lE8yTX9z1D1hejZIQvNvJbsjqhlCiMoA2NwV4167lzai1GM1Xf+qVqtb8ke6dRkenqS1ie0NVFoTcH4E3x/yE/4rcPCjQbjqiEcEiY5sZHt1JfXLrj2+pZI131dt01IvzbAKtV2Sbc2QxxjudutQ2iLyE3nmI75tjYkoYSTYcHLQF5e7MQeXIrtNCEsQkJN0THwXKTpzbgKOMMKPAOE/xib8FbJvJm1YhTSvlRcdIQ8s3t1AiWGe9U8T+x11iUXsUQt0DtyymPjBJtjNkCKdQQbPEEFR+c7jfLQP0XvmTlvqJNzdE3omO1uY5QKNK1e3/cnr6z7NA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7740.namprd02.prod.outlook.com (2603:10b6:806:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 18 Feb
 2026 04:17:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 04:17:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Topic: [PATCH v4 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Index: AQKdvUB/9mf9o/Y3llQwVwTGdfX7SgHg+Kp5s/RygfA=
Date: Wed, 18 Feb 2026 04:17:29 +0000
Message-ID:
 <SN6PR02MB4157B6F44266C4E813D3CF74D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260211170728.3056226-1-anirudh@anirudhrb.com>
 <20260211170728.3056226-3-anirudh@anirudhrb.com>
In-Reply-To: <20260211170728.3056226-3-anirudh@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7740:EE_
x-ms-office365-filtering-correlation-id: 8d975f4e-011b-4261-bb42-08de6ea4a153
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc6c3c4/rztiZGf6bH6e/ZClauV3F4jLkNmGBAwbGRCmFJaOE0W3ogSraW17CoFMnoWoKlWs0mX714hB01xD7LCwrzeljiAx0pLgQfla8WRI0PLByZ8kNVN6oYNcpK8bn6fV4SFcrf6UnK2CMTRy0tfDlUzCFsMfvcuNA9ewFPfoye+GUOokVhoeMuwJmd1yrCNKLCjzcydS/2tdMZpuU8e6+6GRQ1F3nIPHfxQDsIvFRNYSDE2RZyiVYNNbdzxU1B5RA9OYTZWUCoPQbSiIO+LmRM/BfqoAemU2+WYLv3DLufeWyqrygaPKq1TWdPs1rwbAEGwoEXcw7jjuryXjrXJwt/tDguQiOICN6xXSARP4MXSF6fjslHVt4mOItHU5jekt1tZVRX6LWBupaReIMoOr+anYFvHdtqG1KrC8GLl22L/ck6LuQWA4Q4m3s8Huo+M+U2vXnE7RubaXvNiLM6DpWlFNOzmy8kVl2XUlSR9CSDXLYMnaklPEWXGzq7QqILKDSG/aAixoTXPh2w3Yg/FSpOYgIEsOzx5BRTibJL0lFOv5lzGU1VG9CNchres42QUBiFpxYGlT13MZ1lqKnc5DOs5bly4/wgVg0WOT0D8DVAveQV1NXYpjgNCyOCs7R5C5vcGrv7jUw72TlMJO6bgTdXZW3WJu5dCnaQr5XneIuSIxoLq0h/+8p9m2/UCEGz5BwqwMYdhrXMYAHDJgszsjGKeecZSO2IYsqQHSG0EsSSwQSERnPA7
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|13091999003|15080799012|8060799015|41001999006|31061999003|8062599012|19110799012|461199028|40105399003|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JopYkFYQDDjQHSTwGsmTm9Hd0T4Nhlf7JBtoxdA64Rkp9m4hqSspR0E3B8rL?=
 =?us-ascii?Q?YTvL4Hafu4JjVHrOYxbXpk4614KuRWo8OwoZEdze/SRR471QB0gP/2Dcx0D1?=
 =?us-ascii?Q?1p+V0ScANR2cA8kfE+w8Q83ojo4bGpS1w9KSAbLhQQGZGA1JxDPPD/s1eSCN?=
 =?us-ascii?Q?lkSFEDVEqhfurBpbL5F1qedewch81PHE8LewqrGZtjxxCvynkq1+zO6QEfke?=
 =?us-ascii?Q?4zfUTSjKKvwjvVoBDMxs6eMPT7oROG4JtVtjdDYKUDeOrOmV+/7PYYSHlN69?=
 =?us-ascii?Q?UgjjLB+Mck4vSRFmvG7L3m5XZAy2zb0X7eugFYFlOGpbLg7O5k10uV5Gk3jy?=
 =?us-ascii?Q?QzH+jP0WAlIwOZSQ+QH+V+j55QyEmcNBpr1XbV3sm3vou5OqQwvIlzM9IB5Z?=
 =?us-ascii?Q?8GnNviYwikZDx2n9FVcmkd/gz7W+qHxrDOtA8D9im6AN63bYxziFJsdN4G46?=
 =?us-ascii?Q?+40zemCJcGcDP7uKUKHnQ0yP38rkdbv6/rN4jdtM/sUk+yEIO5XY9sM7RYOC?=
 =?us-ascii?Q?ZQh0zzTJcQIG9ES4O1m822u481WlYrSpGRISLrHehY7K2dsLNmTfERLQ+1NY?=
 =?us-ascii?Q?pHQ09g0Tubi456HtwgIkV/OHtjwrvzVj6HPTmRJMBXx3/JRvxj6ean9ctYcw?=
 =?us-ascii?Q?OHKWZk8XF8z27ybkSCg00q31SuTWi4IHHmEUHE2VxkcP9++86SufcLDkLAu3?=
 =?us-ascii?Q?Nms1IOProjWrI6r0ywv2C8ryBIdpx2zqJ7wyOLx7UkXVdsko9VyOgJb+xxW/?=
 =?us-ascii?Q?0J1P0LOsT55ELJZ2jj8qGmtfeSUQRkGxNlWkx6GpKG5eFmeIjYK+Cu7yFGJ8?=
 =?us-ascii?Q?zdO5ujqyrzK53UWdXCzRstCrHN8dUBWj1PuZjH0Vu5DMqDVsQ9Sbu/qmgz58?=
 =?us-ascii?Q?HR4mlTtzD+d4d3zYuhmA/WEOg6Fgrco+qZnfO3h0Zd8U+9RWcTrmbZrMEG3j?=
 =?us-ascii?Q?0C3ykUMPKNBbydwp9enKl17DJe6IXYjaRd2+9R6BjHkA7Xx/PMgyGZSlWdyJ?=
 =?us-ascii?Q?WMhmfN/xa/xgULT9+d4yVeUZhRB9vCTIDslrDvok6kDeArFhT2ylu10WLmNh?=
 =?us-ascii?Q?+aPRAeU6qEWPRnS4vdulYz8EWFW+20WLAkZYbhlhO80zOajFhEjupR5si42o?=
 =?us-ascii?Q?8MZkzdcba/Q0mSF1W+UEpjT1idA2Ao4IFi69tITgjVmlOL3z4JQRhXX+eRdO?=
 =?us-ascii?Q?3VN5WlT9AUlyaoQA7zEQuF27pbPWfSSZ11QaV1+oqzY3IHho7isu5jJfSbnO?=
 =?us-ascii?Q?mjmYOconFzW2mO0wgA3gd5RmI5frgJWhHfgnjIAmYA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G4S9ezfot8Tz0atTI7pZBNX9KNKtfDzkBgkP37wS6qaU1pbZkueMGhNrbYrV?=
 =?us-ascii?Q?v2DJVITxW1wOiLa1E2X2AVui2u6JHkE/xbQOdn4ojtgx+nccYSsy/gRMew9E?=
 =?us-ascii?Q?yODrhq5aWvSin6RBbpXa1g8q1/ASwChR/6WdhnxOpAjug+WCJH5f5Y3rhsUT?=
 =?us-ascii?Q?aUC36/WxUjFBddTG5INpCF1+ED+67sTMBZ41tScSnITabiBCUq+zuQMoZ3mr?=
 =?us-ascii?Q?D2/EpaOSUdGvSeLZMXQeDlGViY3h9o9IaoW1UGYc6PpnPck34rckd8JkudLt?=
 =?us-ascii?Q?pWfVglWWlAiYOmBZg8jubpxamIAA0g4hCboffIlf+eflgWoUe8/NdeLTDFZg?=
 =?us-ascii?Q?FSD+axOKldEIbNvR0/f8LN3FWgprkVpfS2tI7GmJnvb6iMdioQH8IjqKaEMX?=
 =?us-ascii?Q?UptK3PrHYkEcw0bLl6836Vh0MXuFQcNVMKAJkt0wP8kUXV5OzOJl3NAnyprv?=
 =?us-ascii?Q?aJylnNHvoaC5/VZuOLiEZIxMJXXz7HLZo8KnbLixxaw3l0ayuBtZ6hup5Udk?=
 =?us-ascii?Q?7Bu5+9+cltTpkpTRA6p/8WIzr0DdGdgbQ1SR28eZXQW3q2otL6Pgz1Rvohe6?=
 =?us-ascii?Q?z8uQBafT9QgrXkkTDlRbaciqKsQQ29Ym9UNP7+qsWwcSbhcsBNlhpIFScY4j?=
 =?us-ascii?Q?jM5LbAo6V/teDYGi4NSBn/7a01DBem6p5TsHgNKei8oDIafVJspsVktbXirf?=
 =?us-ascii?Q?zqw8sO3zzijos+n2/G8LOSan2Qd6vhfnRuE/twbDAkCyDBPewLBhFwGdvkqP?=
 =?us-ascii?Q?0VoMQmyKV0Jwuy2WXdMPaMjYTM6QT+0j/KVibVb5bCWYu9asGvovVCOQfZ3/?=
 =?us-ascii?Q?km6qA7/SFTyhPC6vfRG7UnvDjlPQt5TBgSUxQyO5E9/flO4RThoT7p7gzAQP?=
 =?us-ascii?Q?CY5h3tJWZrf6oSnGHWmvTb3v+8a66GCQWHEhVdTP6OEl6RWlpvUeXfLPFtdH?=
 =?us-ascii?Q?dNuZsjK8GXyKJ2SnCMnENTojFeuAD5DkNIcht+0ZEsR9tD9TllexEjszNgHA?=
 =?us-ascii?Q?ApDIEyTcGzZul6xc1HEvyB/EbQuQs3nvGjbEkMkKduAwBxcJHyumS0M1g9LI?=
 =?us-ascii?Q?3r0l5f61TMu+CRyyo92TyABXLrFs1EXCJJwAq8azjpOWqCTpAuXuKpGg3hKx?=
 =?us-ascii?Q?Ynud7UEjhwqqWeg1jipTrmVTslTCqLT+NxGkJgoIuGgMZad9dEMe7jScr6T+?=
 =?us-ascii?Q?TYVCt3mzFQL1Qug2/rjN8BF9m9QeOhfRt0OXEM6Q4+6muqxFS+vt2BHCk2cO?=
 =?us-ascii?Q?7XPu/E49P1EHndS/49yMHKQaTsYyO3BibQQ840QLkgqgeITg3wiPaHRK23rY?=
 =?us-ascii?Q?tsi7reQG9vYRxx6pCLU8/9JlPG8t7dyahByzQOtcmdYJb6XCcVmURQgBct1H?=
 =?us-ascii?Q?EC/7xOw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d975f4e-011b-4261-bb42-08de6ea4a153
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 04:17:29.3212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8878-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,anirudhrb.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 18E41152F42
X-Rspamd-Action: no action

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Wednesday, February =
11, 2026 9:07 AM
>=20
> On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> There is no such vector reserved for arm64.
>=20
> On arm64, the hypervisor exposes a synthetic register that can be read
> to find the INTID that should be used for SINTs. This INTID is in the
> PPI range.
>=20
> To better unify the code paths, introduce mshv_sint_vector_init() that
> either reads the synthetic register and obtains the INTID (arm64) or
> just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_synic.c     | 112 +++++++++++++++++++++++++++++++++---
>  include/hyperv/hvgdk_mini.h |   2 +
>  2 files changed, 107 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 074e37c48876..7957ad0328dd 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -10,17 +10,24 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/reboot.h>
>  #include <asm/mshyperv.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>=20
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>=20
>  static int synic_cpuhp_online;
>  static struct hv_synic_pages __percpu *synic_pages;
> +static int mshv_sint_vector =3D -1; /* hwirq for the SynIC SINTs */

With the introduction of this variable, the call to add_interrupt_randomnes=
s()
in mshv_isr() should be updated to pass mshv_sint_vector as the argument,
and the #ifdef HYPERVISOR_CALLBACK_VECTOR can be dropped (yea!).  My
previous comment about the generic Linux IRQ handling doing the call
to add_interrupt_randomness() is true for "normal" IRQs but not for per-CPU
IRQs like these. So the call to add_interrupt_randomness() in mshv_isr() is
needed on both x86 and ARM64.

> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +static int mshv_sint_irq =3D -1; /* Linux IRQ for mshv_sint_vector */
> +#endif

Documentation/process/coding-style.rst says the following in Section 21:

If you have a function or variable which may potentially go unused in a
particular configuration, and the compiler would warn about its definition
going unused, mark the definition as __maybe_unused rather than wrapping it=
 in
a preprocessor conditional.

You could tag mshv_sint_irq with "__maybe_unused" and avoid the #ifndef. Bu=
t
see further comments below.

>=20
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
> @@ -456,9 +463,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
> -#endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
> @@ -501,10 +506,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>=20
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>=20
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	enable_percpu_irq(mshv_sint_irq, 0);
> +#endif
> +

Using IS_ENABLED() would be better than the #ifndef. (See Section 21
of coding-style.rst about this as well.) You would need to drop the #ifndef
around mshv_sint_irq, which is fine.

	if (!IS_ENABLED(HYPERVISOR_CALLBACK_VECTOR))
		enable_percpu_irq(mshv_sint_irq, 0);

That said, I prefer the approach in v1 of your series where basically
the code says "if we have a sint irq, enable it". This links the enablement
most closely to what it directly depends on.

	if (mshv_sint_irq !=3D -1)
		enable_percpu_irq(mshv_sint_irq, 0);

But I realize the approach is somewhat a matter of personal preference so e=
ither
way is acceptable.

>  	/* Enable intercepts */
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D mshv_sint_vector;
>  	sint.masked =3D false;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> @@ -512,13 +520,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>=20
>  	/* Doorbell SINT */
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D mshv_sint_vector;
>  	sint.masked =3D false;
>  	sint.as_intercept =3D 1;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
> -#endif
>=20
>  	/* Enable global synic bit */
>  	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> @@ -573,6 +580,10 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>=20
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	disable_percpu_irq(mshv_sint_irq);
> +#endif
> +

Same here.

>  	/* Disable Synic's event ring page */
>  	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled =3D false;
> @@ -683,14 +694,98 @@ static struct notifier_block mshv_synic_reboot_nb =
=3D {
>  	.notifier_call =3D mshv_synic_reboot_notify,
>  };
>=20
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +#ifdef CONFIG_ACPI
> +static long __percpu *mshv_evt;
> +#endif

Same comment here about the coding-style.rst guidelines.

Furthermore, mshv_evt could be directly defined here as a per-cpu "long",
rather than a pointer to a long. Then you don't need to do a runtime
per-cpu allocation with all the attendant error checking and cleanup, which
saves about 10 lines of code. So

static DEFINE_PER_CPU(long, mshv_evt);

drivers/clocksource/hyperv_timer.c does the definition for stimer0_evt this
way. I looked through all kernel code and found several other places doing
the direct definition. I don't remember why I didn't do the direct method f=
or
vmbus_evt, but I'm planning to submit a patch to change it, which will drop
a few lines of code.

> +
> +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> +{
> +	mshv_isr();
> +	return IRQ_HANDLED;
> +}

This function generates a warning about being unused when !CONFIG_ACPI.
But see further comments below.

> +
> +static int __init mshv_sint_vector_init(void)
> +{
> +#ifdef CONFIG_ACPI
> +	int ret;
> +	struct hv_register_assoc reg =3D {
> +		.name =3D HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
> +	};
> +	union hv_input_vtl input_vtl =3D { 0 };
> +
> +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
> +				1, input_vtl, &reg);
> +	if (ret || !reg.value.reg64)
> +		return -ENODEV;
> +
> +	mshv_sint_vector =3D reg.value.reg64;
> +	ret  =3D acpi_register_gsi(NULL, mshv_sint_vector, ACPI_EDGE_SENSITIVE,
> +					ACPI_ACTIVE_HIGH);
> +	if (ret < 0)
> +		goto out_fail;
> +
> +	mshv_sint_irq =3D ret;
> +
> +	mshv_evt =3D alloc_percpu(long);
> +	if (!mshv_evt) {
> +		ret =3D -ENOMEM;
> +		goto out_unregister;
> +	}
> +
> +	ret =3D request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> +		mshv_evt);
> +	if (ret)
> +		goto free_evt;
> +
> +	return 0;
> +
> +free_evt:
> +	free_percpu(mshv_evt);
> +out_unregister:
> +	acpi_unregister_gsi(mshv_sint_vector);
> +out_fail:
> +	return ret;
> +#else
> +	return -ENODEV;
> +#endif
> +}

I have several thoughts about the #ifdef CONFIG_ACPI.

The coding-style.rst guidelines in Section 21 also say:

Prefer to compile out entire functions, rather than portions of functions o=
r
portions of expressions.  Rather than putting an ifdef in an expression, fa=
ctor
out part or all of the expression into a separate helper function and apply=
 the
conditional to that function.

But more fundamentally, it looks like the #ifdef CONFIG_ACPI is there
solely because acpi_register_gsi() exists only when CONFIG_ACPI is set.
The rest of the code doesn't depend on ACPI. In the !CONFIG_ACPI case,
your stub code returns -ENODEV, so doorbell & intercept SINTs just don't
work, and pretty much everything is non-functional.

This patch doesn't allude to any future DeviceTree case that parallels ACPI=
,
so I'm unsure what's expected in the future.  If such a future DT case is
murky, perhaps drivers/hv/Kconfig should give MSHV_ROOT a dependency
on ACPI. Then the #ifdef CONFIG_ACPI could be dropped, along with the
#else stub code. When/if the DT use case comes along, the dependency
can be removed and the code structured to handle both ACPI and DT.
The code to fetch the INTID via the hypervisor synthetic register, and the
request_percpu_irq() would be applicable to both. It's only the GSI
registration that would be different, and that could be pulled out into a
helper function that handles the difference in ACPI and DT. I haven't looke=
d
to see how DT does the equivalent of GSI registration.

Another approach would be to add stubs for acpi_register_gsi() and
acpi_unregister_gsi() in include/linux/acpi.h.  A number of such stubs
have been added over the years. Saurabh got one added in 2023
(commit 1f6277bf716cc). Then the above code would compile even
with !CONFIG_ACPI.  acpi_register_gsi() would fail, and you would get
an error return. This approach produces cleaner code and is consistent
with similar use cases that depend on stubs provided by include/linux/acpi.=
h
rather than #ifdefs.

And either of these approaches avoids the unused mshv_percpu_isr()
function and mshv_evt variable.

> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +#ifdef CONFIG_ACPI
> +	free_percpu_irq(mshv_sint_irq, mshv_evt);
> +	free_percpu(mshv_evt);
> +	acpi_unregister_gsi(mshv_sint_vector);
> +#endif
> +}
> +#else /* !HYPERVISOR_CALLBACK_VECTOR */
> +static int __init mshv_sint_vector_init(void)
> +{
> +	mshv_sint_vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	return 0;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +}
> +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> +
>  int __init mshv_synic_init(struct device *dev)
>  {
>  	int ret =3D 0;
>=20
> +	ret =3D mshv_sint_vector_init();
> +	if (ret) {
> +		dev_err(dev, "Failed to get MSHV SINT vector: %i\n", ret);
> +		return ret;
> +	}
> +
>  	synic_pages =3D alloc_percpu(struct hv_synic_pages);
>  	if (!synic_pages) {
>  		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto sint_vector_cleanup;
>  	}
>=20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> @@ -713,6 +808,8 @@ int __init mshv_synic_init(struct device *dev)
>  	cpuhp_remove_state(synic_cpuhp_online);
>  free_synic_pages:
>  	free_percpu(synic_pages);
> +sint_vector_cleanup:
> +	mshv_sint_vector_cleanup();
>  	return ret;
>  }
>=20
> @@ -721,4 +818,5 @@ void mshv_synic_cleanup(void)
>  	unregister_reboot_notifier(&mshv_synic_reboot_nb);
>  	cpuhp_remove_state(synic_cpuhp_online);
>  	free_percpu(synic_pages);
> +	mshv_sint_vector_cleanup();
>  }
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 30fbbde81c5c..7676f78e0766 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1117,6 +1117,8 @@ enum hv_register_name {
>  	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	=3D 0x0008007A,
>=20
>  	HV_X64_REGISTER_REG_PAGE	=3D 0x0009001C,
> +#elif defined(CONFIG_ARM64)
> +	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	=3D 0x00070001,
>  #endif
>  };
>=20
> --
> 2.34.1
>=20


