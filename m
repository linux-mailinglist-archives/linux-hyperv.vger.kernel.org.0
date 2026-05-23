Return-Path: <linux-hyperv+bounces-11178-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IFFG9zEEWr9pgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11178-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 17:16:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78C5BF9A1
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62054300CE5E
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E127A47F;
	Sat, 23 May 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rLda0nO3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012066.outbound.protection.outlook.com [52.103.14.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBC175A8A;
	Sat, 23 May 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549401; cv=fail; b=Vbk8e0WSBYm0NVnf5OelrC2kUBrvNPW0v3yvW9gyFDcu+5D21gbjIPkKf4CSiUnwW5Hgh5gukihM7B/bpllm7Tz04qUxihaX8BTx2cq+Gqtdm24M1cJCmqMpUKEcEbvWdHjhbBAAwXXEOXPYqvzFGJ80a7poREl2e7uDryKkUNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549401; c=relaxed/simple;
	bh=3X+ma6utHjqRhOJAOsHKDBGh8cDbwZ83gIXCG8pNxMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4s29Qh6iWXa5hxVcuaFrxYTlEVQNuOfTCj/PhTbYp3wYi65QYazIThadty4LLOuobEyhfE5yqva5qY8qL3koaVkxq6lCbHl3pw1QPZup3EnWkusfFUamrEvsy6CqJoXdzuUkWdiaFuscv6tujIAj//bNmweYHefXRWWZ1f5rgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rLda0nO3; arc=fail smtp.client-ip=52.103.14.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ/hfpLshFbzLArdnQaBxn4kjNwG+rsWLSWjmKWDmAIPQ6CbtN4UBv7/GHAPY4v4DuAiDcUpD+Fw490XbazvOa7WZVgELAX6MI4MwZ0yflgn9YQXXR7vsz2KpNsVBTzzo/whHcqwOGUtc3xU4NHurCogSTvyIXKAO1mKQnQFicpS4azLrQ2ZGEhelTEjK1yyWNAc5x2SgMzyh0zDo/DmuaBQ7AXh+v1Hp6oiozQWoI5+NiSFUZnTjzvZMNnNP6cKul8RkGoDSnxvek5634lC9iaa7unKxHrLpn/AyF8QZuOfzQX2BiSYWTDy7gB0mkhrxYmOMMRgdbpJG8sZGV4OPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyerMwdIk77fkQN4MAE78+n3S2aPrvdHvrDQ/MAxShI=;
 b=eiaWxSjSrsZ81un2zbz0T9N0dfA3/S4PwHPr4OFfHxBpK0GEnN7WbXu64Ra7zZeE5u4zcHhMygrv55BgjHA8VwAH3F9R1M4SKeuizyDpEcWRRyclU2pSDJSHdspep1HT91TrGF/YkxqBoL5SOwPLCfRD7liuHY82j2QsbBLBucE+RxzeNdhRl9sZsUFay+s5r+ox023iqgQZcCHJBQGiuNSg09JzrxQ+Ry2yCyQ0F/To8pGJNz3Qe5VE88yFbDYiuzMBpdlJPik2QcUmLmzFpxXV/qY3PV9qUlcaTZQ4hJwYVzW9UKMdBMcYUHGLSuf4+40PnO1bg1ykdNFPM99o0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyerMwdIk77fkQN4MAE78+n3S2aPrvdHvrDQ/MAxShI=;
 b=rLda0nO3sBx6CL0uoxjnxe4nRxkPRQNoUS3B8kWtwK1/dAtx+wlhf+kos85lKGm9mRZWvpDr54hYTwDrnvDqxLvZo9m64o7iRCDSa6IaOvc9N7a+Wai0CBIAaxoshE9cz56wAmsUFRi0C8dKwoqCH8nDMgNI5BjDJutlAzKBbmcma3xJfleIfqffjYxOUh6peHmgExrnRaxtxtTAS3iVkTRknmE8SSSm/D44uC4SQngt+jYtG4IaD1HbVNsRGZXMgb8ftQSGpXSLAyUn5sYpCPzVLTne39esAFcRBteR1tZYdvz/Ulguzz7HRKhNXR4tea3sklCuasW754+oNYz7CQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH3PR02MB10217.namprd02.prod.outlook.com (2603:10b6:610:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 15:16:38 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 15:16:38 +0000
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
	Deepak Rawat <drawat.floss@gmail.com>
Subject: RE: [PATCH v5 1/2] drm/hyperv: validate resolution_count and fix WIN8
 fallback
Thread-Topic: [PATCH v5 1/2] drm/hyperv: validate resolution_count and fix
 WIN8 fallback
Thread-Index: AQHc6rxkBstGlz14A0u8i/tKrUkC/LYbuMtQ
Date: Sat, 23 May 2026 15:16:38 +0000
Message-ID:
 <BN7PR02MB41489A7D961B5A1E763ED448D40C2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <cover.1779542874.git.me@berkoc.com>
 <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
In-Reply-To:
 <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH3PR02MB10217:EE_
x-ms-office365-filtering-correlation-id: a58a994b-e62e-4d98-f329-08deb8de4937
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|12121999013|13091999003|41001999006|19110799012|15080799012|8062599012|8060799015|31061999003|37011999003|19101099003|440099028|3412199025|12091999003|102099032|56899033|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ye0fOLA2rhCnIyCGdKQEhT0dOajL50Wy9UTvVhI74LwDZ/OLbDqdgR6ykLtV?=
 =?us-ascii?Q?Hpt+0xSbLIPcjFgreXu3+1ICpPUSpkHmLTGL9MMUQLFidXk30uhZVXqGA5V5?=
 =?us-ascii?Q?gkhTKu+y3lD7TE4EmoYVJLqycAN8vWpoxd8PvN/Mi/iGH8PnLVnTSURS5OFC?=
 =?us-ascii?Q?JcEf0v5Ji/eyFp52R6oUSKcAE6gd9ZHynDnEgicYy0nnr02O0wB/cDY1uMmN?=
 =?us-ascii?Q?Uv9mirFQSCl46VOuKorMU2scftS/C2QZxcgn9a+eGw2i2NkRZPloWz3AfBjO?=
 =?us-ascii?Q?GBHze1hfCYKF7+pwLcUSzZ1Y0yaGaKwIFpcq2WD4SGqYZ9orgcbaQr08efJH?=
 =?us-ascii?Q?rXrHX3d1BicwTBZ7g8bx0H1vUqaSw+VZkruzNBUlHkExE/4mF4/phvhvadId?=
 =?us-ascii?Q?lOT3RJtN8pcozm1YSrLOKISsCnrbvSINE6x+c7Pu9w6LhInI9QXCNu1kfWYL?=
 =?us-ascii?Q?u/UXhFIGWEqGCs7VV/bH0uCvLoE4YcEbFbM2D6q+6qoBpo+4YBdvoYr99xpA?=
 =?us-ascii?Q?isWsVu0vlHyb0mI+DhANEhjfNNmVAK72IwFIB/+LJS+2KAQ3OEmI+hkbKpPk?=
 =?us-ascii?Q?VBrgMA5AvRMlAGfciVSqZugazoRM9HdNTS78Lz3hyXhI1SFEzXxzjy3OCUji?=
 =?us-ascii?Q?zJLeLnWoCFV/pIUmypaznhtOK6cd+Oc2RSzE1pq1SMH3jfrIfDj1DTzFiF60?=
 =?us-ascii?Q?SZtLeAFrrT7o+3CPe5io/hOXtmoGeVmNTV89mDay08onP/pIIEX7Ln4CO777?=
 =?us-ascii?Q?0I1bp3bMvqXMV5dJnwB4PMfRkP9gO83z2/Wh1GuKgBW2SIrZask6jfy3dv9k?=
 =?us-ascii?Q?zOMPmBp9h2OzJpACeyoMysZUCf34ygwp4VK1bUgOIzsQ7yGzaa7SKJVLTD2M?=
 =?us-ascii?Q?d1TI8xstmXW8iH7T2DrUjtjUf1yfwMuAa7u9OqmXBDC0jhGziHW8Xy+y/ljS?=
 =?us-ascii?Q?ObFgGzuTSexJvZ3CU0dFZDiy0jttz5dEfwlqE/Rj4yIqAExfIszSIsJzPby2?=
 =?us-ascii?Q?r0rxe5PKNdkaK2Y1AdgzfmzwI6yvTvH97xCFYQ1f+Wu17QTqclYzdv5NbZ9E?=
 =?us-ascii?Q?fO6q+GPBX+AnoYaZrOmvfutOVWO0Nw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YJIVvl+vSUbFRes0whd5pywnZIggldLWbFoqzYNQuHZvAUrzVTNVvnb+3/+H?=
 =?us-ascii?Q?+EbvAVehE3NNQrqlndJY6gVgDy1TWpzNGYlBDMcFF18AzzM/nNy17uVp4mbl?=
 =?us-ascii?Q?QngHIIncl5x9ipfegzalrSYBcUpoyZyMWVv14O9g3uk4xfxHqyxiWz7xMxwb?=
 =?us-ascii?Q?mETn3YUs9cYTkPWx01IUk/7o3M5q0zX+tUfGzedVkWMsMb68835WQHHXW5wZ?=
 =?us-ascii?Q?Y+xT6Twnbhg2ziDSgFNEHaMYyf87wbYUz8WK7WUyAh6LgANu94QYgfuvobsM?=
 =?us-ascii?Q?gpxlL8PwjkqziStOZYZZn2Zip60Omu2rtF0Hzte5RYSt+7flgAfdYWJPeP5S?=
 =?us-ascii?Q?2VNqjAYeBy64PvFqQ4yTLHwO6PMcTmV+UguLuuR7zoQqOE3yITdGtX4juaoY?=
 =?us-ascii?Q?UkrRe/ZbdC8Ls9ghNdATnZZRaq7xCIXhY3AVtYuDoLs/CjfxbJJMYVPS4/CN?=
 =?us-ascii?Q?+ums27SQ1fD8NloCfyXidZzYBDA+W3XC2hWaLtvFL2sGVgwjzD5891baBl7S?=
 =?us-ascii?Q?EEAfmUdY8ve2swSBUWIzIAh/njxl7ItFN3MlplYr854SsMBWqomYs2F7rc1I?=
 =?us-ascii?Q?hbAq0CETY//KennizF+9WEHibMaH3xbCSqFoxNRfJOj6bfTmb7cRJghMVK0p?=
 =?us-ascii?Q?DwhjyJauii85uKy6apce1UU7eQbJCVGYD4AHySpqCx4rjDx0Maf2bQal7rX/?=
 =?us-ascii?Q?m/QAZUZzNupbgR6CM6DZmhHTqSx6FW77f8VGjrnt9lXuRy9qNAq9mC7sR+bN?=
 =?us-ascii?Q?Nrkf+HozuBjo+ni+lgWrNz4EaoIp3FBlLQirKIDAZeE/Nl3+/JNAtNvAIlbK?=
 =?us-ascii?Q?dRWEZlSfXRt/tt9ET5vVL6iGQVXPQ1WyZknz+hwvri0DO3J3YlmM1utxmNJO?=
 =?us-ascii?Q?O5aF5e5GT4trSXYagujAtPEn7Zw48+6OXMvG3Aby+xKa69VDffO6dULkRz15?=
 =?us-ascii?Q?zmfE1AbmN5nyYscDqdEZUCOI4FANM4H5FKEZFbHHjn+2NBUsA3+cN2Y2sTQZ?=
 =?us-ascii?Q?IBMw2AFhEhfmOKWmeW/NVuZu+/mHdHy4XtaLA73PNS+USXcyVxlg2jLID+4Y?=
 =?us-ascii?Q?1fQjNE0BfWm4kq3tS5mRjqa6LSmYnzQ5MqJfUpaXhs3LyosueoA++7Tt2n43?=
 =?us-ascii?Q?DcFnuqW01YYX+hJBZLeAl5k0oRVil0K6ldXpgwTF8gkbagZrAjeqyDyVxYTe?=
 =?us-ascii?Q?Xad10EBC7aCKsI03ddXDRLJPFMQOJc9pxo/9ibG6MqnrQ1jqPqJlZx7+s0Rh?=
 =?us-ascii?Q?EM/JC1ekL6bsJiICbW3P0jSewkn7OSueyvKfocJ4nQuMbJqTmgwV/epo74pV?=
 =?us-ascii?Q?gHAACHQCPxwIi/ubx6DLGy4dA5nod7fpgSb/9w9VDmR0kwRz9JCz10RJqEXq?=
 =?us-ascii?Q?zJ2uCiw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a58a994b-e62e-4d98-f329-08deb8de4937
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2026 15:16:38.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10217
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11178-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.877];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,BN7PR02MB4148.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: BD78C5BF9A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berkant Koc <me@berkoc.com> Sent: Tuesday, May 19, 2026 1:08 PM
>=20
> A SYNTHVID_RESOLUTION_RESPONSE with resolution_count > 64 walks past
> the supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array in the
> parse loop. Bound resolution_count against the array size, folded
> into the existing zero-check.
>=20
> When the WIN10 resolution probe fails, the caller in
> hyperv_connect_vsp() left hv->screen_*_max / preferred_* unpopulated,
> which sets mode_config.max_width / max_height to 0 and makes
> drm_internal_framebuffer_create() reject every userspace framebuffer
> with -EINVAL. The pre-WIN10 branch had the same gap for
> preferred_width / preferred_height. Use a single post-probe fallback
> guarded by screen_width_max =3D=3D 0 so both paths converge on the WIN8
> defaults.
>=20
> Signed-off-by: Berkant Koc <me@berkoc.com>
> Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Cc: stable@vger.kernel.org # 5.14+
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

I ran a basic smoke-test on my local Hyper-V instance. I can
confirm that no error messages or failure were generated
in the "good" case where the resolution_count from Hyper-V is
valid. I did not simulate a bogus resolution_count and ensure
it is detected.

Tested-by: Michael Kelley <mhklinux@outlook.com> =20

> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 051ecc526..c3d0ff229 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv=
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
> @@ -508,9 +511,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>  		ret =3D hyperv_get_supported_resolution(hdev);
>  		if (ret)
>  			drm_err(dev, "Failed to get supported resolution from host, use defau=
lt\n");
> -	} else {
> +	}
> +
> +	if (!hv->screen_width_max) {
>  		hv->screen_width_max =3D SYNTHVID_WIDTH_WIN8;
>  		hv->screen_height_max =3D SYNTHVID_HEIGHT_WIN8;
> +		hv->preferred_width =3D SYNTHVID_WIDTH_WIN8;
> +		hv->preferred_height =3D SYNTHVID_HEIGHT_WIN8;
>  	}
>=20
>  	hv->mmio_megabytes =3D hdev->channel->offermsg.offer.mmio_megabytes;
> --
> 2.47.3
>=20


