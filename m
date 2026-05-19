Return-Path: <linux-hyperv+bounces-11029-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKFRJsuuDGoClAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11029-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:41:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 357FD583CC1
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18018304DFA5
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FDB345CAF;
	Tue, 19 May 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LcLVJd94"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012058.outbound.protection.outlook.com [52.103.2.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404D314D15;
	Tue, 19 May 2026 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215601; cv=fail; b=eI4PHSImIeaC94QzuxCd4VPllDll1umxOsf+FPOQYGj2AJIGOtnaDfl74Ooh8uZxA722li2Hz8t1fTA+9YcOPmFEZW9k0G29X4QvwMeJYX8Uu0+3FSxORApRNCG9aaGRikUW/TzNI8FK9jTFKYPo/jv9pPmf3qKlzxUx+aHNMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215601; c=relaxed/simple;
	bh=PynHmHGtSgcCOGtzNMBxPj58YfFFXXeuvYbVY+Ie4qA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUvaELZC4o4rQH1djfralQ5S2uA2h+5afcfmrs8hhi9Lq95SWm+Qtj32FXchRHHj0t/DV3elkitPyNI3NLEIUCcrujIipWlK+sUtXZO6iQ8VEzmEV/JjPGQSR4iqbn8FAA1bTckv6m1BxuokrcA8a6cTiwDZmHF79X2ysKeJHuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LcLVJd94; arc=fail smtp.client-ip=52.103.2.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chEhtWcMQhAfBIQ4XGIl/pXCkJueP2iUM/GLi3Hogsbp1Oevpqm5y7vCAtWQ2Y3I3JRRlwAvbQ5BpNx+BT/Sjs4/ld52LdYfnyMXXrfBT1Ylym8kF4LWKxahswnp/RevY3rrwVcRwK5a4svb8qVGSFWp0fNEaEcNSYYm2dvbDe73Ve4TuV38qHkasdrnFKAxUA8U5K3F9GM4bYdiEYlJaWiaBgxmlbj0Vk7OyaeYfPEZIIeRUSsISZ22JGnQM3d1ySLy8JdUavjHfv2blQwKwyEDtsGagInieyBgmkhe6TbZOkzzfuxELDkm36zCFIbwnozIlUSOkRwSzxLk+n+5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZXITpIZL2U7MVxRMiM4UBnBUVtQrNypxPrB+iiAYds=;
 b=IFdWYrzmFaoseStYYM9UJvFF33BPlj/NT3mVEStwqV3yl3UEUIhMOPx/rjs7bzfexUAokjmAc2JeiBmuciCUDb9MMcDFF/eSbc503v/CMQ8gvkaRNqnwYyeeR8+IdEa7Tc9Cq7Po8QbnHrLMOEZYgt1EaeBc/idfaKQUQsARctISxUBj8frOr3+zl5HJp0zCrdgVcnR63pjxIcbZR9QobvLtkjvUIGHw6uY3ossgnQY8HokqImmGA4PdNOGBlN3K/5KphT60ln7CWtqsamGqhppY+QRv7B0QJ0TmAV+qg8iVFpNKQkBL+LTd4fepd6/L5fDIzmHMNAq2fFBvDxu7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZXITpIZL2U7MVxRMiM4UBnBUVtQrNypxPrB+iiAYds=;
 b=LcLVJd94948HToPrO+eYQyz3+jQ8ZrbfHqL4QGT3rul2VD6yCLUtUuwQXDNDrW+hmusIdNQcLxzmyFVu3U4wjCvIq/ghwt73zOUpUZxcDZp1KsIKty8CTCsD8CKpWUsIZVFQYwbkPEpPANZuf8POoq5pb83gHuO4y1bHS5qrkcjSVBfqDJbGAb4HM5ro5jhA0f/RVyxgI0RCbgdDY229zzpOLql+XR7J8b03k6GqWBnjkcZ+V2XsTgFixoWM7dXKjtiWIXcje+oDObOP5ozR9n7wmyo3Yjx9joijX0cC47tEHnM+awjLm3HGPF/TuYEFGl5TNFUMTKMrzCaaVm6AqA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7358.namprd02.prod.outlook.com (2603:10b6:a03:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:33:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 18:33:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden
 VSP request paths
Thread-Topic: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden
 VSP request paths
Thread-Index: AQIUBwkfFERYES9mX2x90t/+K692oQKhdNWNAcc+V8YCFxepWgHIRczZtWTtIvA=
Date: Tue, 19 May 2026 18:33:17 +0000
Message-ID:
 <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-patch1@berkoc.com>
 <20260517134926.B4179C2BCB0@smtp.kernel.org>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
 <20260517-drm-hyperv-patch1-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-patch1-v2@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7358:EE_
x-ms-office365-filtering-correlation-id: 1ba2a0e4-7bf9-4e58-c1d7-08deb5d51839
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmprXCmKzjWdGU57vAD/nj2c6Sd3NQd1pBVcKon3Egb/IOTAiFnyPk1gR9zWBmwMnUKoxt6XrSOXP3ubj86o0Sth+7tGa8irCVzpg6Zuzkv3ld/DoR12eAiNTDJGndzbhVEqE7wA/L3xadtRJxHdR/72QPYcuhm67mNHiGcF3IFHfcCi9YEIg7aQgkzdJtu4D0m7bnIAoCyy82zsQ8HLGLkFdJdYjiureQhnL/jHl8l0nSUTN63yUYj3rugfa1JmcmJ/IShr7wrW1RXn+6DLJjFBwnlhMbuQvhBchsor7c2MDaOQ8nKY8k7CzEb8mOui7T9M5Twzwubb4T7D5WkZWUhe9sositZ4qzy6dOkXrjxGV1Ho/Oh7MJjemzJHo2ZEWcZnH3QqPaLcu/88dW7qIYeh3StB+v2X5Bs4vIp7/IVCl5QJGgO1MA5MqkURrGveTnS8P+O1IMJ89oHm+Mi4VnZe+uKpVRyPDWjPx5cwVTAyVu+qIVTkyA/6YZNpluUcQzjwwRDRfxuUQY/uuV1kj6JZ6yon3aqAT1/4ae509SCDSxNN+UnlWXnxvdIPPL79Vj8DAqCcecVdl2RhjeGl1pigo/4oD+BTsq9uUj41U9lkO8Bkf9P2myk3Uv9I8+/iRxii68k40zwBY8duaFOkXLOKncA7Tqn0JGLk5vvBlHyy8fxafGIsIAsWS+dzPXGBE2IGmSJG7wn1J2vB00nEECZ5LkycQp5lkDigw5lPWvZVn2pOwjS4mpZecY2NmyZSWkg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19101099003|55001999006|51005399006|37011999003|13091999003|12121999013|41001999006|8060799015|8062599012|19110799012|15080799012|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tpv3EzKt0lPOclZh/iaM6dC/qyy/07Wbvg1Yi9itrSoNsu+cINPkbnSNulzT?=
 =?us-ascii?Q?jBY3WYOpihljQn57J0CfOdpu5GgE1nASqGlkvSkGC+YCP/30vo5OpMUSAgPy?=
 =?us-ascii?Q?bRaFJSvQ+SRcVSuOQC0HqlzKVFTni9BN3IeqL2k2Y3QcJTzxi50a2hMPgP0b?=
 =?us-ascii?Q?RWOTBur2cq/e8Lk2mZSyDyilqyQqrsaA975S0Io+6PBBXdsp/a/KrfOQxFna?=
 =?us-ascii?Q?YYwnJOuRIePDoEXzxCz7y2taQpVtYZohxF3p87lsUSY/nAZ4v4lFpN1jXk9s?=
 =?us-ascii?Q?anK+/OXZ21Euz5NRuJDQKUcc7AL+JsfRVZ1Rdxx7xx5WraURA2U5/OyQrjk8?=
 =?us-ascii?Q?GMqcrQMCRbI7GnVh9kPbPRjHRNg09NX+4rYPw04OhZbCt1eAFJftOWak10eQ?=
 =?us-ascii?Q?4uITjvpq4abBivMLJXO9olV6gwF0B9snpqNhsvZuxxw7vaEDckP8litj3P1A?=
 =?us-ascii?Q?qeqeMkYMSddL+V8RWgfLHvohQ8XBDUbLJUMkZU0K8tgcK8LLvpZEQ4vWIqWg?=
 =?us-ascii?Q?1GFKyp0SC2Px9p5L61xTY8HhXaO8YD3w1vmXTLgc5y0483E1O3qTQIwlTJ/9?=
 =?us-ascii?Q?ZmfqWpCH7kskkImKp83mw90ld0w/vFksSMKy7W4seBvGbf954vXAQJYZjxVC?=
 =?us-ascii?Q?P+5WP2kX7ISfZUYCjWAPF9BUmYxPSBYlgqsRWIole3JaXEzyl6Z7JfM6BER2?=
 =?us-ascii?Q?ChAVi4mLtu6c5hmW4xK6ioSNokFSjkgD4Q3Vo+4+RUAgQ814ifV0030iuT1q?=
 =?us-ascii?Q?h1WVtO+yKpHaVyvd1jw8x4xHkq7a7VZbgrsn5aIo8maRdHUtEW8DRt2q7Y+G?=
 =?us-ascii?Q?GFfc/wVqFymBB0uOC+SNigSlH6b4lY6sJEH50datLX2Cbmgf4V1gqdhtIitE?=
 =?us-ascii?Q?nUz3nop1nQcBaYH3F+dTU9lwzZCVuQKGSTFxOlz6HhDqD9di63iMAESj3nct?=
 =?us-ascii?Q?5iYcyiAGoXLyJSoxab0W3qNqN0eBe8/dUbBZ4Y1RMrMBP2UxatwUW2h9Hp4Q?=
 =?us-ascii?Q?bYcHjwoQWhD3u2yAcUGAOTjYev4erM39wsSyNppFzLAaMcN7hocFOW2O101j?=
 =?us-ascii?Q?+FTIMgelLSWbCAsNVZfF51TsOuQp/VXQtL+8hZ1sCBVpdF/tRPLpWIqfSzaq?=
 =?us-ascii?Q?Bqw7fT9LxYw2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pcZc9GlmAK/gOGIXT/SNET9fV1X2mga/ZYr34CarWsMqTRdGbNrAvhJfyR+a?=
 =?us-ascii?Q?SRDgZ5j4f0AGJEY701TDiARc5Cr6FENKOYBj1wjsMraV5MjOle7YjhsTNxRh?=
 =?us-ascii?Q?g5k+6Q0RuBx1mzsKkNmsat/q0gCl9BT0go2+3ySLftTNwOuo9IeDarnshSlp?=
 =?us-ascii?Q?ml1LlqOfcA+9b3KK57azHEQckLJrESqj3kC//1JDjakMmIfDPBhPwQvE1ykW?=
 =?us-ascii?Q?keiD6yvBoavFLegIxy2utnotj9W9tPgi9dvpdG6gIENKHfhy4eFuiBZq80ir?=
 =?us-ascii?Q?r+tNtsaHBQJxKOpo5Z4mFlhC37SksCWR/jVWsEf0Z454Edvj0ENa0pikYZTd?=
 =?us-ascii?Q?SXbMMzZF94dXAa9AgIVZ+RKX9tRG+cZqdI4KEaHdj+OvNgpsr9xnNRyLjjr9?=
 =?us-ascii?Q?PitDCYA8QSQZFBTxjdV48oOCDNhC8mgvHnMJao/cnTyDaWR8Lx868qYAjFZE?=
 =?us-ascii?Q?dDGISTxgG72qqdgxuADZblWMM/Y2mI1xmu7456B84cEcv20a2BfK6CgfEBGA?=
 =?us-ascii?Q?+NfDtXtY5YGdq+vZzS42SttAi1ElmJszO0A7tIEe0ePogIGHA6TvNtKzsBXw?=
 =?us-ascii?Q?k8Q1oPAycjzNMjLNHVCAQlzJUqFJ2wmT/dtnsBvtlm7kcZtPnqRywNuw2dl4?=
 =?us-ascii?Q?KEaOqhRrwh8xN5syvSntl8gEqngbheShtBSOxMKjicNsFpb1mPJh2nF+lECC?=
 =?us-ascii?Q?0lh5rs3TqHivtrHpclX8Avs3VK7KLPUEF/jieaYqFfKzfIs4pEj5/Xt0Fhki?=
 =?us-ascii?Q?NK4TuaVDqay4y3KwsXo9aBU0sE6reo1JXZq5nEYt2DzqlcM6SH2U2zPmo+nk?=
 =?us-ascii?Q?NonjNv5ME5RhmtbQT9XV3F5glhpMHlwfm6MTiRWui/nxQSvxNWqsGPfa4AxL?=
 =?us-ascii?Q?96IcqwCKkSn/J3XOzrvNL94NvJ9T2MfJGsnO2ktlm65ty8Hw2zQcB+NtWCs8?=
 =?us-ascii?Q?uwEK7EMgxRtzUBp4/yjCS85WySLGuJRy2ckli8Ymh8NhimCeX/raLMEf2kl2?=
 =?us-ascii?Q?dFwbXYuxe9GJ4dVc8cUlgRbDCCPBZFNw7PyWmpO/lpCp9jNB6OUAsQ2EnF6+?=
 =?us-ascii?Q?hEw4/DRiKwbskwn+Ck74WBrAMugCiuEiOWVDBnZNdH6a8DAMB8Fbf6d/QKZQ?=
 =?us-ascii?Q?5QSr8dMLjW7iZcOR+gmAKPT8c4o7EMMrKZZBYebZ6oYDfRJt4rnwYZloGTcy?=
 =?us-ascii?Q?63DY2YZFkPhDXeINCY4lqGaKdfxVddxUPb+cgnuCHCuy/zo9LvhPNl2Oo/t3?=
 =?us-ascii?Q?LL/OWd+F1DY4zPLjzg2xpQbaK/7R40Pn2jTO+6yc1GPkNtUu95g3Xg7HU/J6?=
 =?us-ascii?Q?bSTcJPpgw0YwhY2a7wE2aFr4ZlmYedUh7AXIaDv1WZazAD0FZIju7AHabsyR?=
 =?us-ascii?Q?oAn0N0Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba2a0e4-7bf9-4e58-c1d7-08deb5d51839
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 18:33:17.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7358
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11029-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:dkim,berkoc.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 357FD583CC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berkant Koc <me@berkoc.com> Sent: Sunday, May 17, 2026 7:25 AM
>=20
> The synthetic video device parses a SYNTHVID_RESOLUTION_RESPONSE that
> contains a u8 resolution_count and a u8 default_resolution_index. The
> existing check rejects resolution_count =3D=3D 0 and an index greater or
> equal to resolution_count, but does not bound resolution_count itself
> against the fixed supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT]
> array. A host that returns resolution_count > 64 together with an
> in-range default_resolution_index causes the subsequent loop to read
> past the array. Reject any resolution_count that exceeds the array
> bound, folded into the existing zero-check so a single log entry
> remains per failure.

I think this is a good fix, but let me provide some background. A core
assumption has been that the Hyper-V host is not malicious, and data from
the host can be trusted to be well-formed and valid. Linux code interacting
with the host does *not* take a paranoid approach and does *not* validate
every value received from the host. Existing validation is ad hoc and
probably not comprehensive.

A few years ago with the introduction of Confidential Computing and
"CoCo VMs" in in Linux, the assumption changed. (Hyper-V calls these
"Confidential VMs", or sometimes "Isolated VMs" -- unfortunately, the
terminology is a bit scattered.) The host is treated as potentially malicio=
us
and Linux code was hardened against bad values passed from the host. But
not all drivers for Hyper-V synthetic devices were hardened because CoCo VM=
s
on Hyper-V don't allow all the possible synthetic devices. The Hyper-V synt=
hetic
frame buffer is one such disallowed device, so the Hyper-V DRM driver was n=
ot
hardened. The allowed devices can be seen in the vmbus_devs[] array
where .allowed_in_isolation is "true".

All that said, I'm in favor of adding hardening, even if it is done pieceme=
al.
There won't likely be a comprehensive effort to harden the Hyper-V DRM
driver unless the frame buffer device becomes available in a CoCo VM.

>=20
> When that bounds check (or any later failure in
> hyperv_get_supported_resolution()) returns an error, the caller in
> hyperv_connect_vsp() previously logged a warning and continued without
> populating hv->screen_width_max / hv->screen_height_max / preferred_*.
> hyperv_mode_config_init() then set dev->mode_config.max_width and
> max_height to 0, which makes drm_internal_framebuffer_create() reject
> every userspace framebuffer with -EINVAL. Populate the fields with the
> WIN8 defaults that the pre-WIN10 branch already uses so a failed
> resolution probe degrades to a usable display instead of disabling it.

Yes, this also makes sense.

>=20
> The driver also issues three sequential VSP requests (negotiate
> version, update VRAM location, get supported resolution) that share a
> single hv->wait completion. None of the call sites call
> reinit_completion() between requests. If wait_for_completion_timeout()
> returns 0 but a delayed response later triggers complete(&hv->wait) in
> the receive callback, the next request's wait can consume that stale
> completion, return immediately, and parse stale data out of
> hv->init_buf. Call reinit_completion() before each send so every
> request waits for its own response.

This change should probably be a separate patch, as it's not really
related to the bounds checking issue. You could even argue that the
bounds check and using the default size values in case of an error
should be separate patches, but it's a judgment call and I could go
either way. Combining the first two works for me, though someone
else might disagree.

All that notwithstanding, I don't think your fix is needed in its current
form. If wait_for_completion_timeout() times out in "negotiate version"
or "update VRAM location", the code returns -ETIMEDOUT. The caller
then bails out and does not send the next message in the sequence.
Eventually hyperv_vmbus_probe() fails and the struct hyperv_drm_device
memory is freed. A similar thing could happen with hyperv_vmbus_resume().
The memory isn't freed, but if the resume fails and is tried again later, i=
t
should be with a fresh copy of the saved memory image. In that case, the
completion should be clean for the retry.

The problem case is "get supported resolution", which would leave the
completion in a pending state if it times out. This could later affect
hyperv_vmbus_resume().  I could see reinit'ing the completion in
hyperv_vmbus_resume() to handle this case.

But double-check my thinking on all this. Maybe I'm missing something.

One other comment:  In my view, your commit message is a bit too
detailed. A commit message should focus on "why" the change, and
less on the details of the implementation. Explaining the failure case
is fine, but don't recapitulate code that is straightforward and obvious.

>=20
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Cc: stable@vger.kernel.org # 5.14+
> Signed-off-by: Berkant Koc <me@berkoc.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 051ecc526832..3b5065fe06e4 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -223,6 +223,7 @@ static int hyperv_negotiate_version(struct hv_device =
*hdev, u32 ver)
>  	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_version_req);
>  	msg->ver_req.version =3D ver;
> +	reinit_completion(&hv->wait);
>  	hyperv_sendpacket(hdev, msg);
>=20
>  	t =3D wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
> @@ -257,6 +258,7 @@ int hyperv_update_vram_location(struct hv_device *hde=
v, phys_addr_t vram_pp)
>  	msg->vram.user_ctx =3D vram_pp;
>  	msg->vram.vram_gpa =3D vram_pp;
>  	msg->vram.is_vram_gpa_specified =3D 1;
> +	reinit_completion(&hv->wait);
>  	hyperv_sendpacket(hdev, msg);
>=20
>  	t =3D wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
> @@ -383,6 +385,7 @@ static int hyperv_get_supported_resolution(struct hv_=
device *hdev)
>  		sizeof(struct synthvid_supported_resolution_req);
>  	msg->resolution_req.maximum_resolution_count =3D
>  		SYNTHVID_MAX_RESOLUTION_COUNT;
> +	reinit_completion(&hv->wait);
>  	hyperv_sendpacket(hdev, msg);
>=20
>  	t =3D wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
> @@ -391,8 +394,11 @@ static int hyperv_get_supported_resolution(struct hv=
_device *hdev)
>  		return -ETIMEDOUT;
>  	}
>=20
> -	if (msg->resolution_resp.resolution_count =3D=3D 0) {
> -		drm_err(dev, "No supported resolutions\n");
> +	if (msg->resolution_resp.resolution_count =3D=3D 0 ||
> +	    msg->resolution_resp.resolution_count >
> +	    SYNTHVID_MAX_RESOLUTION_COUNT) {
> +		drm_err(dev, "Invalid resolution count: %d\n",
> +			msg->resolution_resp.resolution_count);
>  		return -ENODEV;
>  	}
>=20
> @@ -506,8 +512,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>=20
>  	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
>  		ret =3D hyperv_get_supported_resolution(hdev);
> -		if (ret)
> +		if (ret) {
>  			drm_err(dev, "Failed to get supported resolution from host, use defau=
lt\n");
> +			hv->screen_width_max =3D SYNTHVID_WIDTH_WIN8;
> +			hv->screen_height_max =3D SYNTHVID_HEIGHT_WIN8;
> +			hv->preferred_width =3D SYNTHVID_WIDTH_WIN8;
> +			hv->preferred_height =3D SYNTHVID_HEIGHT_WIN8;
> +		}
>  	} else {
>  		hv->screen_width_max =3D SYNTHVID_WIDTH_WIN8;
>  		hv->screen_height_max =3D SYNTHVID_HEIGHT_WIN8;

Is there a separate problem here in that preferred_width and preferred_heig=
ht
are not set in the pre-WIN10 case? I'm not familiar enough with DRM driver =
code
to know how these preferred values are used. It looks inconsistent to have =
the
two fallback cases be different.

Also, having to duplicate the fallback code is distasteful. Instead of havi=
ng an
"else" clause, maybe have a follow-up test for screen_width_max (or any of =
the
values) being zero as an indicator that they haven't been set, and apply th=
e defaults in
that case?

Michael

