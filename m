Return-Path: <linux-hyperv+bounces-8546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cv1AmvueGkCuAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8546-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 17:57:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BD980F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779F43022973
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9835B63C;
	Tue, 27 Jan 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bycb2GKy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011029.outbound.protection.outlook.com [52.103.14.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0C3559E4;
	Tue, 27 Jan 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533031; cv=fail; b=HYHYxKdhQiS2hXOM2/uYjWXprieVCKBEe97sUY+0e6AUxvJTELlCXmiz2OjbDrUrLgqJTGigmhOQaghAAyDrTS8xNgYeIozpvSpKnn28pqf8I2PNpofk9+WxjxmAM8Ma/2Uv4HB0FppXWl98Jwx9awubJGUnsHJ7a1VNk6mPyZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533031; c=relaxed/simple;
	bh=/k3YSuvvkpNogtscOOt+YTd09PhjLfGeoOsDpFuAcUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V9246ZJAAtM7hxLAr8nQFAjhboMBN+BWDXlirNjIwKmIumX3WgPWFKtN861c/TtZR/tQZBLlNPtOh04wkC2RALO9JLEB6rwz5gYXYlvQbLhfyMD/OErFY0sgiQ8Eq7XiTBmeMwMHJdlZHWCe4rwI91r+KXpaidDjVHG2xLhjmto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bycb2GKy; arc=fail smtp.client-ip=52.103.14.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs6SlI5LSb5IIjgzrNxDHDCY1KxEq1+oKrRqjtU328ydmPyQekXD8pHdOjN+0JavcY3cnY8N3Pm5CRvG42P84g6JFgDRhCfmPN388iRKl2vFuZgCX2jbKozCNX0D+1vppNwpO0km3ICQqQup57vgnFy5lRsoWwUO+G/gsWTX5gTr2d7FjYRrz5xA7RYUpdIiZoNTn3fd47zEni+mXwyyq1eogXd4b03aiirvahKMezuHKkxCO/qDcjdJ7SgovrsFoX/KSX+N6hmLg5tOmr8mQKod2n0Lg4r1jpo+JkrmNWCJsiG921OAjexqjiaLS8hwqOgHXZXA2AA6R9Tz3Lz5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc20DwVqiZUtBxeyi2x1d1lRSuEUOVIZbklNLmPYdNE=;
 b=OzotdlPiJK0Zg/kdPgIAIkMFXeb5/Tyj5Y2Gzvkvqqv0w0M2gvWuckGRI3GMtUi4l+FsN7I6XmnUu3PC7Z9nuHNmg9+ujNEUvmpOwHGv7wRn0TRFSsiOgjMRwuiuEWY9PQdUhOq+fAPeMWh/drH3jXW47uRC66C2N/RPdGJTlENuRiRIx+s9HCuO+9lI2xL5hOJqu4HBOoN0YfYVVciwURerYhwWDWl4GRfgVqiaWlF2QhZqtVAHPf5AGgGu0DV5eBA4ZuOgO2lZtfxXso1L6DEMHgY7b2SYTsRT44i/WDIItNt04MsPHQVI1GNsVa8hVDHJnIzEme6R7fv+9iBXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc20DwVqiZUtBxeyi2x1d1lRSuEUOVIZbklNLmPYdNE=;
 b=bycb2GKyN16dvsUlsaH3W4utvkOvw1+cwGso4t4VvuwZ4jsOWbJybHGz9V9Rccv8VTPTj/P0IaRpJ6kaSqh4M182dqASXX6/IyDHblV1NYR5yGyCbLjq0dbWtXSpnBz6YgSRqQtLK+7tiGLv7/9adw7G090A43CB+DXRiraN4lNiXXmt3QRE3bsQJ/0cV5zvD4c8nYyZ0O/VMoxwJDMv7mmG+jw2UgDZ5NpD9mP10gLa5b5sBGIsY/ynWsGNE4b/OQ/R6seUMI+b1tUqJC+0juPsNDcWpzEb/F7dB/Z+L64CyGX3zOL5MXOW680piz4lJ2xf9mybWCjAQrZvhM9XMQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 16:57:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:57:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v5 3/7] mshv: Improve mshv_vp_stats_map/unmap(), add them
 to mshv_root.h
Thread-Topic: [PATCH v5 3/7] mshv: Improve mshv_vp_stats_map/unmap(), add them
 to mshv_root.h
Thread-Index: AQHcjwYx3+K6XL7Yxk2EcNhePdEoCrVmPW/w
Date: Tue, 27 Jan 2026 16:57:05 +0000
Message-ID:
 <SN6PR02MB4157C65BAC4AB4315606F521D490A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260126205603.404655-1-nunodasneves@linux.microsoft.com>
 <20260126205603.404655-4-nunodasneves@linux.microsoft.com>
In-Reply-To: <20260126205603.404655-4-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY1PR02MB10459:EE_
x-ms-office365-filtering-correlation-id: 5a939407-5c7e-40e5-3b45-08de5dc519a1
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|13091999003|31061999003|8060799015|8062599012|19110799012|51005399006|461199028|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SXnokIGD6tm4u55dpXPH96Tvd6fcUb277jfWaQA704muK6B5bvhv9p6aigsz?=
 =?us-ascii?Q?cQ3SZeULEg71ahMY1BPcdTgECH20f+Mu0A50Co/+UYYbLCHecCoUpgQOS0PF?=
 =?us-ascii?Q?jepnFx1EfMLhW4e/aA3QDsi/CaKPLYsUiQXHgaitqVl+85OzT/7MZ1DxeDGU?=
 =?us-ascii?Q?D3uO7xlyk/7JrVEVUuujhmuseQvv940RS74hIUisNfms5LCZgnlNhjlragm2?=
 =?us-ascii?Q?W52pwQbFHgj9k12VKpOD0nv45ujxihPjFPRJBmb+LnsF3oF4QZvap0hiR1/f?=
 =?us-ascii?Q?yyx1EEpvGGnSnsleIvnY/MzAlTF+MiXO6A7xH479/EzMz3FYuhAALjWcRmI/?=
 =?us-ascii?Q?5ObQPUXkY2C4WwDVHktOMW0OaV4G9qVt3hTp/45V92V9NDwKRo88xi/ZHGck?=
 =?us-ascii?Q?BQFH1JG/KVc+mf1ODap05NqMltbpBt4/Xt0+EarLAxkuXFp9nLf1dG74odCq?=
 =?us-ascii?Q?Yn0pp/0T0/Oc6K7YlPfAt/AkL05fCpdUE64EA4sEnZjlAOYEKnV/dNn+UeEW?=
 =?us-ascii?Q?awEa47KCny7SP0AiUNkHAuI0QY6MUWLEGD1TQnyI55w270nQH7wu4+b6fciK?=
 =?us-ascii?Q?rU2aUTC6WOq9KhOJSsXbo3XKpakYnN3/EbYvueD4cBNRRXMzekHBcmnfMY2T?=
 =?us-ascii?Q?oeiJyDcieRqf2+zc+T03K6HrEv4BgFanViLHQmvVv5qzdSiymwtOoJAQMr0V?=
 =?us-ascii?Q?usBKKroWBPh+CEj63TrCShcilOCCp9aDTGUf0qtPzl5I6A4d8IzKyx3SyujQ?=
 =?us-ascii?Q?7jfXf53IdVXRddLFE5dByki2qnfvR3goFNi9qxyTZ/j9Uu0D/qRWg9uSI9hw?=
 =?us-ascii?Q?6Zc4H+iKRIKIggiijO7KVQpBwgJBiZVvYswd+usydK6Qfi2/k6Iwz/e06brz?=
 =?us-ascii?Q?KEY9stmART4Hnf/jI8m2yOUlWFGWLwfS8zAnN5rDjFxWaz8XOMAVPiQ7GMo5?=
 =?us-ascii?Q?vmrZ1Qx8fzl4otdFFp1D8M48/xePt/FOcNCirlYdFeUdumgPi2TKaX8jBxQL?=
 =?us-ascii?Q?0crTAL+34ed8IwFjrpbpX3eU8U1nj0FvI1Jf8McBQGcpuiTlKU+eogjaoTvQ?=
 =?us-ascii?Q?XrNpQGXPFk1oa3NKxDUGslzWeFHuJdaYiy8Em/fo7siEN+3H72Ku3V2/7GjC?=
 =?us-ascii?Q?v/mNwtT8+dNfEP6yPLBMz5uFzdTgGT+QuTn+hKQN0OroIDNIluxgF+ggOOHn?=
 =?us-ascii?Q?W0WQN/bMAVwFB99azFm8FK3ZgEFLc+SVk5+Mls7xJ7mmMAr0Ah4sZy4395nm?=
 =?us-ascii?Q?eCpw6/g/QVlXpVfEJM9W?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2SagSbMrnoIdYrtU2oBv6X+QrnaX1rE6oTOSGDrwxmtEXDcWxnC0yRllGDrY?=
 =?us-ascii?Q?Krh48kzx0WWEW8t5reTxRO3ZB9mwfzrEkEMFKcALNsve5h5G95QlvwfOpgEZ?=
 =?us-ascii?Q?tDlsIXRqlmNAbMT2T62AZ52o6CKHrg2lGav9csSspZgNGufZQPnlh9XXWi7r?=
 =?us-ascii?Q?uGrocT5BamSRK8YELYj0P8nXSzuoJJXzXxsPJsY7nxEDsx59LslrWKT+Bgq5?=
 =?us-ascii?Q?o8gsCryIwCCdgtFC6fBqy5OdogkINeEtB0Q08O+B9mUKclXV8KOe6gicqGaN?=
 =?us-ascii?Q?w0ah6lghL33OFlVoQeFrDl1BPl3FE9D2bUmBQ5r5f3Ho8MR0Lu50Nxfr1UQ4?=
 =?us-ascii?Q?TWrBfnfwXiMLHpwYhmJGvr+H4Rz3vCQwYbkCVcmmAUIB0ThrcFCvGExIIHYf?=
 =?us-ascii?Q?uScXU4g4leFnsS476IvtuNVrl6F/Yv7QL4B8pjwLaqnKur5kX5EUjozTEiz6?=
 =?us-ascii?Q?ye6lOcrRuz4JH+QSq6XFZSCUyckL8l7eHUU37spPBdjiPJMK4RFZMnAXUiHe?=
 =?us-ascii?Q?kd73VgWe1WMdCaNsXR5VE4vfiYJFAsBypPMmuOK2TA6bAPRhjy5ucUOcWYBc?=
 =?us-ascii?Q?F+lkeZ0pvdZzwgEhjXfPrxfBT9KwuM3y3xfoqgSecmmqTyMSr/ZUxjkTzvJ3?=
 =?us-ascii?Q?OtUjr1w6jZkiujgN6RUl8LBkKwQ4asmh6aXM0ewwcPY9muoucmII5mjbR1oU?=
 =?us-ascii?Q?nqCuCsWcFJpUrTuWKHIWYLxdUaPFmcAHIPT2gwa7LW9y3ZrybGxr2QF9oO7p?=
 =?us-ascii?Q?exteJz//lZshL2tHvljH2+OhBLlzTLQHg2jOhXkea0KMOB0oQSXcyDMgjEST?=
 =?us-ascii?Q?4Xe4vAt5qEMis0re63gEzIZKqA81sBOZ5zvWbdqyqcF1Zt27tDYoTCigxcTL?=
 =?us-ascii?Q?/UutZXXlNFwBN7css7qSdYgoaZc1sPxrOC9fACWAuiAf4bNNa6fcKESZqxmI?=
 =?us-ascii?Q?BO3+kN614DKPNsU//nFi/QsXTytQt3E3NcPZnbrYlkqtyg3hRWT4kXfvfFGq?=
 =?us-ascii?Q?EKtYsAQQBPxQb7m32NVZb2RKGMtuT47zgCKFNAvxtONckb0EWOcWjMYJjN6I?=
 =?us-ascii?Q?JWZEjyhgVE6U9gZOaBlS/sdSseY4t6eA/8QCAS+Ll1wp2iOxqd8ggATgQhF0?=
 =?us-ascii?Q?7gZwHZ2J37xrs6CI94//O9eH8zLqR/BipSmc+v//Y5OvP6qn9loXMZo115zY?=
 =?us-ascii?Q?pPbsd+QALyG6aD/Zb5QMoaerZPiEiaSMCqoZLmOVRWB6xwa1wjRYrziDrHZp?=
 =?us-ascii?Q?Q7DxgFLfxade44AYghobtxBT+O3EFuKG860tl7xXTgTqOs0b2UMsM+iLOU6h?=
 =?us-ascii?Q?NvmwCMsAVD9VMAkxEVZl8qGGbDoBOUCRUL9de2qJwHA7pU3Qu2KfKrFIp0cm?=
 =?us-ascii?Q?zdejfJA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a939407-5c7e-40e5-3b45-08de5dc519a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 16:57:05.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8546-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 583BD980F7
X-Rspamd-Action: no action

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Janua=
ry 26, 2026 12:56 PM
>=20
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> These functions are currently only used to map child partition VP stats,
> on root partition. However, they will soon be used on L1VH, and and also

Duplicate word "and".

Remember to run checkpatch.pl over your patches -- this duplicate
word was flagged by checkpatch.

Michael

> used for mapping the host's own VP stats.
>=20
> Introduce a helper is_l1vh_parent() to determine whether we are mapping
> our own VP stats. In this case, do not attempt to map the PARENT area.
> Note this is a different case than mapping PARENT on an older hypervisor
> where it is not available at all, so must be handled separately.
>=20
> On unmap, pass the stats pages since on L1VH the kernel allocates them
> and they must be freed in hv_unmap_stats_page().
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h      | 10 ++++++
>  drivers/hv/mshv_root_main.c | 61 ++++++++++++++++++++++++++-----------
>  2 files changed, 54 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 05ba1f716f9e..e4912b0618fa 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -254,6 +254,16 @@ struct mshv_partition *mshv_partition_get(struct
> mshv_partition *partition);
>  void mshv_partition_put(struct mshv_partition *partition);
>  struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold=
(RCU);
>=20
> +static inline bool is_l1vh_parent(u64 partition_id)
> +{
> +	return hv_l1vh_partition() && (partition_id =3D=3D HV_PARTITION_ID_SELF=
);
> +}
> +
> +int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> +		      struct hv_stats_page **stats_pages);
> +void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
> +			 struct hv_stats_page **stats_pages);
> +
>  /* hypercalls */
>=20
>  int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index be5ad0fbfbee..faca3cc63e79 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -956,23 +956,36 @@ mshv_vp_release(struct inode *inode, struct file *f=
ilp)
>  	return 0;
>  }
>=20
> -static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
> -				struct hv_stats_page *stats_pages[])
> +void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
> +			 struct hv_stats_page *stats_pages[])
>  {
>  	union hv_stats_object_identity identity =3D {
>  		.vp.partition_id =3D partition_id,
>  		.vp.vp_index =3D vp_index,
>  	};
> +	int err;
>=20
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> -	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
> -
> -	identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> -	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_VP,
> +				  stats_pages[HV_STATS_AREA_SELF],
> +				  &identity);
> +	if (err)
> +		pr_err("%s: failed to unmap partition %llu vp %u self stats, err: %d\n=
",
> +		       __func__, partition_id, vp_index, err);
> +
> +	if (stats_pages[HV_STATS_AREA_PARENT] !=3D
> stats_pages[HV_STATS_AREA_SELF]) {
> +		identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> +		err =3D hv_unmap_stats_page(HV_STATS_OBJECT_VP,
> +					  stats_pages[HV_STATS_AREA_PARENT],
> +					  &identity);
> +		if (err)
> +			pr_err("%s: failed to unmap partition %llu vp %u parent stats,
> err: %d\n",
> +			       __func__, partition_id, vp_index, err);
> +	}
>  }
>=20
> -static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> -			     struct hv_stats_page *stats_pages[])
> +int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> +		      struct hv_stats_page *stats_pages[])
>  {
>  	union hv_stats_object_identity identity =3D {
>  		.vp.partition_id =3D partition_id,
> @@ -983,23 +996,37 @@ static int mshv_vp_stats_map(u64 partition_id, u32
> vp_index,
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
>  	err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
>  				&stats_pages[HV_STATS_AREA_SELF]);
> -	if (err)
> +	if (err) {
> +		pr_err("%s: failed to map partition %llu vp %u self stats, err: %d\n",
> +		       __func__, partition_id, vp_index, err);
>  		return err;
> +	}
>=20
> -	identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> -	err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
> -				&stats_pages[HV_STATS_AREA_PARENT]);
> -	if (err)
> -		goto unmap_self;
> -
> -	if (!stats_pages[HV_STATS_AREA_PARENT])
> +	/*
> +	 * L1VH partition cannot access its vp stats in parent area.
> +	 */
> +	if (is_l1vh_parent(partition_id)) {
>  		stats_pages[HV_STATS_AREA_PARENT] =3D
> stats_pages[HV_STATS_AREA_SELF];
> +	} else {
> +		identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> +		err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
> +					&stats_pages[HV_STATS_AREA_PARENT]);
> +		if (err) {
> +			pr_err("%s: failed to map partition %llu vp %u parent stats, err:
> %d\n",
> +			       __func__, partition_id, vp_index, err);
> +			goto unmap_self;
> +		}
> +		if (!stats_pages[HV_STATS_AREA_PARENT])
> +			stats_pages[HV_STATS_AREA_PARENT] =3D
> stats_pages[HV_STATS_AREA_SELF];
> +	}
>=20
>  	return 0;
>=20
>  unmap_self:
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> -	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP,
> +			    stats_pages[HV_STATS_AREA_SELF],
> +			    &identity);
>  	return err;
>  }
>=20
> --
> 2.34.1


