Return-Path: <linux-hyperv+bounces-11153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A2KECV8D2rLMgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11153-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:41:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FFA5AC273
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 547B93002B7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4084383999;
	Thu, 21 May 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mElEpqHG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012012.outbound.protection.outlook.com [52.103.23.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC136CDE3;
	Thu, 21 May 2026 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399710; cv=fail; b=X38+tty6jEiTMu2JbZwxdtQlGq30vJvTWCpBClmmb3jAsaMWYFJi7Ebt6UPuJrrP4S3Te6fD3GrevRWT71CPzAZd5jhzEwDsBvUnKwQ3DY8gBbjXQ6fSdEd8RIahOysuS1ZWefMBFwbrMSOYG3tyyd71z1GmRHX2EVlOx7XEz88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399710; c=relaxed/simple;
	bh=P0K+gCYb9thCipOBGEu3AXCZdkYu1Bv1ErDFH4M6R9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg2i/2f7E93CnE75q9qohQYAZnjLAfUz1I7oSKgY7yYSLfTsYLtZV0s3DzCegADgUfuUgnTrd3YnQLf7Wdbl/M46Qv/HlCT/JuE6QhSPfhVS3KOuQmpe31v7nb0sjBxdd0WuPbl7hfZ2E9rs1iZWGe0+hVLv3Gk4UF30camQC2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mElEpqHG; arc=fail smtp.client-ip=52.103.23.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnUbq8uLeQ+7/p0s7167LjRjNSWhWQxFhE246k3t14rBR7nlQoNqLZmnWmWVpzdAcNBGg2+QVLFnCle99Rm/NyfstdfPWUMnzr8Ua1qgvE6yZQmRAyfD9qYAP7Ra24fd1SnIuL+vzEWdxvAOK8OsCt+V4v7RtR+uvCxzRgfFCxaWfVeLjz1KK5gdNhP04k+/iIRn5otV0wE2UWKHeNAGt4sD7ZC//QZyma3mT6Nf5BMoAa9XY2Q9/yqUE7Oo3JiL769rRSfCjKHiD9kvtfqCzfHAJQ/bReMMjfULThNydpRnmbyd9EQRxdwOpHV3ZZUEQ4Z7fVJrr/sMxsfEkCJ5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO+NSvVRCv2CJ+Y8g9Q20qYpk7JFVJh4WCxAuyjvzgA=;
 b=VYGgAdcBHBLTLm5Qhgtknso+riQhFMuFRBkFYrtWy2so4HRtaVfj8ZKSdXkTzN81AD9RsJDIIgQC/MayPjaCHqOhtbtcEavSjGnn2cSiSzK4yHOdrbw/1DWPBsn8SVXBwSpt8VyFT58YEHTmePoTxx3VUhclEkCYcGUxMqe8WU9WjtNhKwnWnqM8vInYY2VzOVnZ8YlJLzB7BGNClI3jRcNABgHW/JwsfFPdiOSi2kvhxBw/PjVbGeW41NhwbK0wa6rC5Tn1z08Z1K2GLTzVqLrHxA6wPLMoOOdgnvMCBhAklKjWZDGKbnrubMUobKctNbCsaFBmdsYiexMIJMB4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO+NSvVRCv2CJ+Y8g9Q20qYpk7JFVJh4WCxAuyjvzgA=;
 b=mElEpqHGTrYezXLZTo2GW93/cvYTYDZ1SgMznYKdX9OiWUlNViAA7CZSmguVhoyG8oc8bU5K2bIPTM3JgUSIKCW7jkvMVs7jwpBU9FNGZWlJSmPdZXv1lPsbfDmcXsdubdDcegTPgcch52Dnu1pwdx+rdlqZy8OW7XHBF2itXRuPxnJOB1QlVwXjlvE26eaKWOkYsRwFphyMGMED/nOvsto28tV1MWKUjLL4S46eG6c87S44cZpBwFaHciqtfmdaWrKWpI13wRK0g4vslbRtNgkIP6A8Dbd0LlkiPPcXc4izWhbC2WjfVLuLdp5FXwKH5Q0uTkF7evhFPHoitNnwAA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7125.namprd02.prod.outlook.com (2603:10b6:510:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:41:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 21:41:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"hamzamahfooz@linux.microsoft.com" <hamzamahfooz@linux.microsoft.com>
Subject: RE: [PATCH 1/1] mshv: Add conditional VMBus dependency
Thread-Topic: [PATCH 1/1] mshv: Add conditional VMBus dependency
Thread-Index: AQG4jg1Jq/Gd2s2baPWUcHBZQDE2SrZhswaAgAAGHAA=
Date: Thu, 21 May 2026 21:41:47 +0000
Message-ID:
 <SN6PR02MB4157FDA8B5EED37A391EE635D40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260521164921.1995-1-mhklkml@zohomail.com>
 <79f77f98-f91-4cf-47ca-c986faed5055@linux.microsoft.com>
In-Reply-To: <79f77f98-f91-4cf-47ca-c986faed5055@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7125:EE_
x-ms-office365-filtering-correlation-id: a7adcfb9-dae7-46d2-200c-08deb781c250
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15080799012|8060799015|8062599012|13091999003|31061999003|19101099003|2604032031799003|37011999003|51005399006|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cx6NJ6wpvcW/Bqf5MQd6CH9ZbBBNU03EbEJs6ffHUT49/GaoS4VnSlzW+CSp?=
 =?us-ascii?Q?MRDRohlKZHkb2odlrj0D4YkvtIGPC+w5Xnr3imcYdZNZnKxhf9L7Uekgqm88?=
 =?us-ascii?Q?r6z3jYZzhEgASlcuYJMSOBwEGfc4MSiSwSGyxkP0mLmf2stYolG2ncooPe5Y?=
 =?us-ascii?Q?mxXQiBCVtWlQgBIzeb3vJQxt/kOyya2MXgKO0m8hghPMTxG9HyPmaG91KFAV?=
 =?us-ascii?Q?t3BTTs6+HV/0Xs5vSQcgLErvb3vb1WN2hHgsG5ntC9zB44jJrAAfird6WeWg?=
 =?us-ascii?Q?WrtZ5s5P2U0A2pi7zcagXSAIyDnXXUyj1ZQ7vgEznVFrlipSe7Af6+xcWGP9?=
 =?us-ascii?Q?93tqt/xpjdDO2uChUo7kNcg0Fhl4mtkLKfWEOrNVWGSyfyAskZUn5Q7GSK2u?=
 =?us-ascii?Q?5yRycJBVxK7iRAN+j7fQxU8rNAC+UTK++1SpjdIEobv9oPqc+AD8O4gSejAk?=
 =?us-ascii?Q?FYSYp3FyBCKAlx1InlSV5ne939uNvKoN2TMs8h8qOw+Kx5ARrCimM3ssrie/?=
 =?us-ascii?Q?U9YiFxfJeNhMYwbrdXv8uo3ujrCRpSvp46xVK9KU/O0gSUnLJvJAmM3PTj4L?=
 =?us-ascii?Q?XaI802KdQGpxQgeB7aXY/JUfickhxJ0BzPFpHfgq4zHSGZCbA0GWDgBiqeZy?=
 =?us-ascii?Q?iFXE1rI1lqK4x24Vjf4DWMDD0we+J/hex/d9lh9rYY3olRs2VzTIcBR2N/eY?=
 =?us-ascii?Q?+n3wLmfRIfcSMSC0ueM9XxQAWQIM6i6l3bvh2J+kbFl0x038Ay4p3lcnvYIb?=
 =?us-ascii?Q?weiyL0zkrqc87gyb2EFo/4O2HZO1x9YXFoxlFqb0P1LPQ5knF+eJ52n6wsgX?=
 =?us-ascii?Q?TpQzNvU3H6zFBkFVwG5NoGFajikqXtooWcXE/LutUGASu9bl8VdvlBQHap/z?=
 =?us-ascii?Q?9LLArm3zQ1HGGo8pg2+FIeXhRAKrs6jFhFi2Pgs8PVND194D0fFM6B+oAu0V?=
 =?us-ascii?Q?BoNxHWEvmg/HtYgTglff7vyn8ipEBlO2jngibNa6cO8egVOOzK63QyI644r9?=
 =?us-ascii?Q?1TufSGU/h8r7l+ibCcdjkrzTIm0L9X9XTGGR+rQKtRAVgDI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LMPfnoXLeFVxJCOKe/WPnqllZvVHzCcQvgRdC8/ZCgC8jtk16Rwi0hDhw+qY?=
 =?us-ascii?Q?cRH7/7EzFj1NkRhfyoDV0XP1fBauM7wdltY+zNfzkimCNvVMSD9LeosT1HtY?=
 =?us-ascii?Q?PMU+rPwVW9UaQ2c5WnzdmZ8yZJRw8b1IFz1bbnoCTj5h6nrBE408+klh9J5E?=
 =?us-ascii?Q?BzS5vhZFQZz1RscIzlbX1AmY0bmcz46ffEslyqgsI9jaM8QQ6xIhpfRtW0k4?=
 =?us-ascii?Q?0/iRd49/AMwq9d61EIez1ZtrKjvEYb7vZcHceivDZiAUehtsUoz63o8DXkOy?=
 =?us-ascii?Q?dKrCZrs/JTcuci444h1iXspKFCOdd+sJ3FlyvX5423ZjhUpFXLIrH3XTnfbN?=
 =?us-ascii?Q?tjtg8BoKQNZIhqMJRNDy6vRVIUiqDuYWrgpe4M+JjqTZPV/4TE4HqndtZ6Wv?=
 =?us-ascii?Q?9QIG5fngLfieD1P4nsAwnpIpB8saWavCVhVB2tYwdLrT4T+8sK0bVIx5SX+F?=
 =?us-ascii?Q?UzRZrICbALcdblawdpNpG1inqeVPGGPIBQqQxhNQKKRM9jMC528sliOeeJxD?=
 =?us-ascii?Q?iJqR+O+wC1l3G+OU2IJSRWjWGdTt6SPgm7q5xR8j4h7bTIEEDigm2BYZ3gvh?=
 =?us-ascii?Q?RaJ+vH7BeVbvDnp6YYYC26cPktuQJQKW1KQAXJSKniDpGZiIjATfWqXP8fdN?=
 =?us-ascii?Q?Tk4UPNZSUDobQNgaiGZxCIUwtc9BpJdxRm3vQvrO7v7Imj0Z6+7VUKBq0sJk?=
 =?us-ascii?Q?q7JMiCDQUZNIO2aS11ovwNYwDKcdqeSzQMpI1CfeS6YTRzCVT1504d5ZDd11?=
 =?us-ascii?Q?cqe0vzs/UviWoLPbt9E5HWjvShVTc28nGzHZ2a/5ovmRUyKJHfzCD2SX4jT1?=
 =?us-ascii?Q?C6cccmpyL2OkKeGw4FzAXA/xun/98SnSZYfm3tKC+ySXPA3hX817/PsRzfn9?=
 =?us-ascii?Q?94Z+TAne0I4fuNDH7ayhR3JiICKTxyBizBQAjdVokZCet9r4CkxxkmXLh5/e?=
 =?us-ascii?Q?9zQ0P5YWgehmFvC6dh9enxoGRcIhTdgXYeyWqYi83LKQdhpbI0JrWUeC3iy9?=
 =?us-ascii?Q?DL3YVuwTcbP0vLnJ2LWGIRi5Vc7xouCqHqatfuADsK4GjNIMzkwdDZsMq3ph?=
 =?us-ascii?Q?KGU0EEDkFTSRPq2gIhTmhwphONgt1Di/rG6Syp9fNRrti46LUhA2yX3WKa26?=
 =?us-ascii?Q?tAwUFSGeVf+28nya5mZgv7zZOtQ4ZZPzFyky1sHkqHTrZTvV3/lCWpzPU/G+?=
 =?us-ascii?Q?bXcDAcLnk3uCP8n/WlSyyBydta5+/k3fNPM/qR3wda0XSO4WX3UwxjY2OitY?=
 =?us-ascii?Q?N6BMNOVu9/McGgCuBoaeqoa6aqbqGtNDJoZquaRB+zpvmh6+GwP2Dcbncrb/?=
 =?us-ascii?Q?POix54hEf1FaEZJ5hj8ar2K6vgxLG8jxv+9O3YXJNuNLtSmgS2r5mYqh/UX4?=
 =?us-ascii?Q?nfZXpGE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7adcfb9-dae7-46d2-200c-08deb781c250
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 21:41:47.1746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7125
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11153-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 47FFA5AC273
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Thursday, May 21, 202=
6 2:20 PM
>=20
> On Thu, 21 May 2026, Michael Kelley wrote:
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
>=20
> > * Add #ifdefs around MSHV SynIC calls to hv_vmbus_exists(). When
>=20
> Could as well do an empty definition of hv_vmbus_exists() if VMBUS is not
> configured, no?

Yes, indeed. I would have done that if there were more than 2 places
where hv_vmbus_exists() is called. For me, having exactly 2 places was
on the tipping point of testing CONFIG_HYPERV_VMBUS inline vs.
adding the test in a .h file.

Thinking about it more, I'll try the .h file route in a v2. That way
mshv_synic.c doesn't have to be touched at all.

Michael

>=20
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 2d0b3fcb0ff8..aa11bcefddf2 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > 	# no particular order, making it impossible to reassemble larger pages
> > 	depends on PAGE_SIZE_4KB
> > +	depends on HYPERV_VMBUS if HYPERV_VMBUS
>=20
> Nice, thanks!
>=20
> Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>


