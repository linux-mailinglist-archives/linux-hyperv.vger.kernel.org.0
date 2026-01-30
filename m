Return-Path: <linux-hyperv+bounces-8611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHAcChXvfGndPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8611-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:49:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB5BD710
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F94300823A
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD427A92E;
	Fri, 30 Jan 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZrmMTJFp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012038.outbound.protection.outlook.com [52.103.23.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406E15E8B;
	Fri, 30 Jan 2026 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795346; cv=fail; b=lCNeK0tiNiOe8ZH5qxfZ5IJKt/Wabvb9V5aK1cdURzGMpT/6IMGFGsM4yHZcDqnu8T3oHV+A+T0+lPgdcm0FefQPtu7PmYXiSYaC/V2NbJa3XxNR0jJhqTqy9TbMZCUAG3y56n4wa3FolwCfvmdDGQqg5zt9QLaB7U4aqoeEL9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795346; c=relaxed/simple;
	bh=KHGvPnHuh/AUfbfcJf0KGDCVuR/H/TeHSNEv9Fh4BFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQbyOLCEFi4U3NdniHNosPUb+1dO59+j0Nx4n0Km15r1QSS7/zAEf4FxMmaLMMYXBrBXZgJYZ6pQorGNmkVUtO3ClhPjaDpGWgQ3AjLj2GEECNT6WPU5+b/Fup1ydH+uk02iMWNUyYmXCKkzDe82BceHagf31vbSAk9sH5XJsJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZrmMTJFp; arc=fail smtp.client-ip=52.103.23.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7lQpeTZrTYU1myh6gav5YpDN2de2Td1j0BNLYrlYPNwfysM5dA9IHuHQQibBmIUlZz9R3Ln5jDfAJVPUo1otxPLPaj7B0KeRH2VPBjoqiknwoWxrXn0gYSEx//bSUgQpxRZKiOiy5ePJU047wrQ54uCJvpO+Oj9hG2Yk8JWAZ9analAaGeIRuATH3DDh6lnAKXUkOnN+P54Zgk+kPErJd8cv5VR+kvZmltmbEbsKlyAb6KhaRDmlN03dQlv/Nx+IhSY+dHpdhyDjOid8OkLjCh+2vYtiJf6ybX20uZvu1sZBOqS1gxEO4dEzURcFwTCZNha+seJ8K7m1wCHKbqDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyLNVjQLlkEj2hgLWTOFjcoMtKHo2Jzw9BCcfIfP0tM=;
 b=fOO4jT6XzKppVkKxSlbKR8ps32r+JXDpqW25VXLpOpZVBzGW24jia6IZT6NBjvV7T8UBk1JMCzCE3jU9hCxnTQ1qdnJ1qoSjsXO3C1tJFhcqmP5OlfKnjcl65pVA7CCRt5tbhr8xa6Oyo5GRmiUe2YjZtRcZJQcH9vP0iJp3Nnjr8ty5PfCNAFrHSbjF0vnw8zkBzngP22RGgwvuTOi4JyxVYG83QrancQB9KRV573yx2dcaJ8Ph7wH8yS6H+dzwf2dkF0KTLr0x7gVegPgg3zvx6O9x0V9BzDYSirjE4vUBjS1MtuAYDXwNBt+nWAUyAu9zgEnPuxnOACxsx1eFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyLNVjQLlkEj2hgLWTOFjcoMtKHo2Jzw9BCcfIfP0tM=;
 b=ZrmMTJFpwUNVpp9YpVDo8mv/4pC8GfChkDTVdVFn2Aymo049jHoHvi0hWTEp7NVzcUtr3ICsQ2WzONM4NLOPN5sQs+KsHWbYy1E9j6yYbR54LFgRl+efFVDrbAowscN1freOcs42wjsoJfjrUVHCYmmyoPdfTCAnUYhtMyvqNF2pkOFtN7kXOoZyn+yulmREHgWh5BGmQeA/oIBIM+EOaLQNjAgGcgUcbpz/Pw8SRqDLDcwfyJbvievz7o2m4+NI9/miIgSirob+anTJE6B5JJdwamiGy4k52haeOJInEXuYiYhHspO1t25asSAHAnQkfIrI52IActcwOmEiGhOwMA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9204.namprd02.prod.outlook.com (2603:10b6:930:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 17:49:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 17:49:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
CC: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mshv: Add support for integrated scheduler
Thread-Topic: [PATCH 2/2] mshv: Add support for integrated scheduler
Thread-Index: AQHci72MSasuUoF5ME+DlBsQrQadr7VpZ+CwgAAmTgCAAGPYQIABFK8AgAABreA=
Date: Fri, 30 Jan 2026 17:49:02 +0000
Message-ID:
 <SN6PR02MB41570DFE89DFBC3476432562D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
 <SN6PR02MB4157EE41697ABC1002750297D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXzsVN3SnNXIDPMV@anirudh-surface.localdomain>
In-Reply-To: <aXzsVN3SnNXIDPMV@anirudh-surface.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9204:EE_
x-ms-office365-filtering-correlation-id: e3abddce-4a7f-436b-f089-08de6027dace
x-ms-exchange-slblob-mailprops:
 igNrEvV8uhEvpyeJ/Jdph30uiRXy5wZPWOCR3hobzXKEERHY1GLewzmVgIJRIfxtuyo7HuX2ApZ3/yN5c72uB7DzCs33y1RCRn6Gh0xtT49Ad/5R6VOesojdhnMG1I7tg7tUkN7lmMXSjcy8TEN3XBnAipQTZghQibsK9ieEwsOYLgBfSt6QFlPOjZdm8WxYJLtVY4W5byBq3v1UAibI2tEiLsKo57ko3s4ykF4hyBPzEHWou66AvraAWCHYipg0fHmNAfZeosg8MlHy01fcv01rPuGrx2W7D9xodulHGwQaRCF2wjxRcGFzAxS2oU4rc7Nt9LE3HIv3UWYa+W3hU/GSdqzVJZSqEl6YVLsg2BPVrp0QSi7hNlQ3wf/4haYSSG/5PF3fbPYTvqCK7HNb4ZbZd/Ni/tmNzwg+T4PiObUiLCDHkkfEqRbQ1SE0mht9jq3iHgo3TProSMiI2WQgKhOguhZeUGDI8gnZee8jXlgvVwwSsRCznUHuQ5fEjO7cfDmAIpuFu+7IfTExstXTeFLvVtVUtIt+yXM5COlDbfp728vNGJfda4kloKOaOs8a2016gMhbMeDNxo8CWD0bkYiXWYnAu+WZCpCPL4f9t4TqUaRgZIuk/H6eKU8wUPdIdFyw/+HcYf0rrLxSeqCTDZZxp6685R6En+jamW/hJ2I0gs6BaSLcxrIBtG6bAdfZWaunBHmvuIU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|15080799012|13091999003|41001999006|51005399006|8062599012|19110799012|8060799015|440099028|3412199025|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oJc81yAY1Qb2mbHlwZPDSWQWzpIs+1ihYxf22rCkox0kC75sBPMCT+Vm2DMy?=
 =?us-ascii?Q?jzyNvmMFpA0nROciuAb3W7EXkTwU7lKiErAZq6s92MoZW5A55wLfhYpfheI5?=
 =?us-ascii?Q?RJAP68aFGqenaOvpzU0L2DKLherRL2tpjZQgFdmobzQI/p4JvwnRkAH9r4+e?=
 =?us-ascii?Q?rTLmMtqzukPKUSaH0AEVADvWxkdSzcQ7GMWWUkEPLas1Hx5tjZnL3vvptBjH?=
 =?us-ascii?Q?8u1v+dYHzDHbyBG5QHm3mXr32xau2sbj1jnhG3ncX2EDTiqLXobEmBzV8nkg?=
 =?us-ascii?Q?u5XkHjCRfmcwSBTG0F6G3kb2TatKtmtbetEYFYExLQTP4PkGElb8QMCXiT6x?=
 =?us-ascii?Q?cdQ4Eo6rdz9v8j/ddwW2FL5ksuwvfnBTQZh6UrroVsKwzc5CC5nJXZlnLGf+?=
 =?us-ascii?Q?HIyDyn2YKa0ZhDgOO2APYoRsRnaVgUGaewSMvu2kv3mOL9QsSzgfuFz5U4M9?=
 =?us-ascii?Q?Lw2nAzT3d2jZWoqHujYdLlFUYN/S3MivshOux8SJyWscVQxNK50sNMptIOy2?=
 =?us-ascii?Q?ProCvWllR5VTN9VoiU3vAEZdEpo5OoDpUqkQEJve8pqCZQtxp18+x1yr0f6x?=
 =?us-ascii?Q?mQVLlgCxl8LnQAxFULSaFPwaK8a7UR+sAP+qLB3VgAVhU8Ylv3VN2Ut+YUhZ?=
 =?us-ascii?Q?VM3azV9WsTcismKmHWFRcZyYhNJdmE1QdjFk0fs81RJ8g/ooL1C6MBuk26Xe?=
 =?us-ascii?Q?iLTNGzwW8+cQE0aXc7ImQ6RUoJqCAg4bBiUqmYWAFRy4V6/toOBUQBahltCo?=
 =?us-ascii?Q?PjtDWf6WoHC8uKuQtCYDOFZw6WRa1U0rRDzbJzf9WN2NEzuC2f+0zV9xQfj+?=
 =?us-ascii?Q?Fvf0nA2XH4QDF1NF23vQ8GQr/pemiYJI54nkOnI0iNFfGWPjvI90AFUyoAac?=
 =?us-ascii?Q?xmop1Geqb9lWlX4G8Xzf+Juezs9HBOQA9LQDwflhPS9SilogIDlHS3njjUqi?=
 =?us-ascii?Q?W17CvglDrOfhHX0/NIKzAXRqTO94X0FE3Uw1I9L5Y0fHup49sksKmvOtloLl?=
 =?us-ascii?Q?h1NQwk0J5fXYw+jIlR8PIaxpbaoVuq3RElxa/NZeefqRyb1hMpQm81TfR5je?=
 =?us-ascii?Q?El/msvXrdm4L/tIbV4r4VbsJNdbnA3FvGVHFtpnLlFTPL2mrl/1G3r/BTM6z?=
 =?us-ascii?Q?oQark71YNCI5DxJvwLDr7pSpNIACsT6Jtua2pWRm6n4fEtTIAEhmfU6oNsSz?=
 =?us-ascii?Q?rzIkZ7T/XtFpoIzdamP+03vkvQOhEnpZC54XXzDZGtrr+eOCU0/TRBYw/M9k?=
 =?us-ascii?Q?rudQIu/vQGLAR1PMYjY75ztrCYc6EnIfHPzDXQXq0g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qBuujdA6lSS2og5EAdaVTW8Qm2B+l/LH1M0R9Qg/W7Lr9pDTE0tKcwQC8U/c?=
 =?us-ascii?Q?P+TT8vYso3gC+ULs33BnwOV7wlYoaxL4QVXDeC347I0JEywG8B+Z/JvwOPr8?=
 =?us-ascii?Q?fSYX1Nn6JRRHpIf6ahIFexF3e9VWbteKX9XX/aocJtVcIsh+obeXI9KE2uik?=
 =?us-ascii?Q?VRteHuCig5RWgOW6kohuOyFteFbGE4dGo0TwQMSSRJTffc2nvMGAoqtFMUQq?=
 =?us-ascii?Q?NpmRZcpc3oyYna8OoaB8+ttUGTDR3pPDicLWO+CaFr5zeOfOXSZUZLarkXJT?=
 =?us-ascii?Q?2t6l9VaJxBKQq/62T76tn1mGiylaG8k0PlmuZbMPOQTVDyp0PmS8okar/pvQ?=
 =?us-ascii?Q?lph9ZT1VYS7fzhZUgXm0eLzQmYXKJ+/hRmluViDYhJWIC7ABAzQLYMhZjxqc?=
 =?us-ascii?Q?7+SKVmVwGZ8eVoyict7kxLqdUY4g1lC+qKXF6JKtg/Hz5MrMPFHdyJxpIT5E?=
 =?us-ascii?Q?xaDajMusJOzVqzyTEiNY+Xgy3QXDh1/zlHYb7WMkFuNfRKZj+FLx7ehdsdsp?=
 =?us-ascii?Q?eLSDQQzd9cTfK4sZxuIKws+uDOq82kYYHGIltdoWTBrc1ur4rQ1PXHkVURBc?=
 =?us-ascii?Q?nN7KT5RJmUCbYCzErNkIE0+pM1PDRa9VOhcjRz6pKEfBRrKMxFx6Wh8RYTjm?=
 =?us-ascii?Q?a1DHby2vwCQx9cOrJzg2xBHYtzN23Ksh6chrckVG8KGg6lbSf36KXmsh1LT6?=
 =?us-ascii?Q?EoigEscNIPSkmbtsFvlHTQnGRJZyXH9yFJbNZtiqkSIF5xagLdSiX6my3oQa?=
 =?us-ascii?Q?4HgIqJp1BLLtCI7M96wnV1QJRLqzAW0VFAm3hn0VKbDlpwhNfOo9RK8V0t/k?=
 =?us-ascii?Q?Wq71YXeyP5TFdnn4Krcdj+WwJ/Rv/EEj80ZXoIMkOeU50j8nNHBKL5n2T7+M?=
 =?us-ascii?Q?X9Vd3VMycBiCtJcw8+rHY5JW17I+t4xMwURGttREedrI4rQihyoRwQzT2B3C?=
 =?us-ascii?Q?6nieG+bSXpnGD/zz2I5hfTT0D8QFjiLm+epv0xu8PklthYEe6w68KwpnC9pY?=
 =?us-ascii?Q?5Qd20Ks/06PJWt4NQmhkOPTYOyCwg4RaL7j+3+6bClBn6cZ++4ztw8ltUGv4?=
 =?us-ascii?Q?nuBoARGHmiC1Q2imDQnRxEOJ0uO6AzmNpTXOS30hjbC/TbfzY3P0do/3crEC?=
 =?us-ascii?Q?0b3akhZhZMcLpu8/YZDHoZVd6/ibjexk7uHL+4JnrLxlY0cAzgLTYY7UrgbF?=
 =?us-ascii?Q?Pb7czlxTw2f3YTEGh07H3E6WUnAJ1EdATJghqc6l5gV3sXLjHY/uaWz2wLxy?=
 =?us-ascii?Q?IMdX1kJtwlIIZXTkpvp7SI2/pCt6gov+CHKACOPF3PkACiOg/AfQYwuogmHN?=
 =?us-ascii?Q?E5jOR6zGWzUlLu93KMcKZEjojm6Q+E9fnD6nFq8fijtr1ULbx11su2qN7jT+?=
 =?us-ascii?Q?mG7Ktlk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3abddce-4a7f-436b-f089-08de6027dace
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 17:49:02.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8611-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 78FB5BD710
X-Rspamd-Action: no action

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Friday, January 30, =
2026 9:37 AM
>=20
> On Fri, Jan 30, 2026 at 01:24:34AM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Th=
ursday, January 29, 2026 11:10 AM
> > >
> > > On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Wednesday, January 21, 2026 2:36 PM
> > >
> > > <snip>
> > >
> > > > >  static int __init mshv_root_partition_init(struct device *dev)
> > > > >  {
> > > > >  	int err;
> > > > >
> > > > > -	err =3D root_scheduler_init(dev);
> > > > > -	if (err)
> > > > > -		return err;
> > > > > -
> > > > >  	err =3D register_reboot_notifier(&mshv_reboot_nb);
> > > > >  	if (err)
> > > > > -		goto root_sched_deinit;
> > > > > +		return err;
> > > > >
> > > > >  	return 0;
> > > >
> > > > This code is now:
> > > >
> > > > 	if (err)
> > > > 		return err;
> > > > 	return 0;
> > > >
> > > > which can be simplified to just:
> > > >
> > > > 	return err;
> > > >
> > > > Or drop the local variable 'err' and simplify the entire function t=
o:
> > > >
> > > > 	return register_reboot_notifier(&mshv_reboot_nb);
> > > >
> > > > There's a tangential question here: Why is this reboot notifier
> > > > needed in the first place? All it does is remove the cpuhp state
> > > > that allocates/frees the per-cpu root_scheduler_input and
> > > > root_scheduler_output pages. Removing the state will free
> > > > the pages, but if Linux is rebooting, why bother?
> > > >
> > >
> > > This was originally done to support kexec.
> > > Here is the original commit message:
> > >
> > >     mshv: perform synic cleanup during kexec
> > >
> > >     Register a reboot notifier that performs synic cleanup when a kex=
ec
> > >     is in progress.
> > >
> > >     One notable issue this commit fixes is one where after a kexec, v=
irtio
> > >     devices are not functional. Linux root partition receives MMIO do=
orbell
> > >     events in the ring buffer in the SIRB synic page. The hypervisor =
maintains
> > >     a head pointer where it writes new events into the ring buffer. T=
he root
> > >     partition maintains a tail pointer to read events from the buffer=
.
> > >
> > >     Upon kexec reboot, all root data structures are re-initialized an=
d thus the
> > >     tail pointer gets reset to zero. The hypervisor on the other hand=
 still
> > >     retains the pre-kexec head pointer which could be non-zero. This =
means that
> > >     when the hypervisor writes new events to the ring buffer, the roo=
t
> > >     partition looks at the wrong place and doesn't find any events. S=
o, future
> > >     doorbell events never get delivered. As a result, virtqueue kicks=
 never get
> > >     delivered to the host.
> > >
> > >     When the SIRB page is disabled the hypervisor resets the head poi=
nter.
> >
> > FWIW, I don't see that commit message anywhere in a public source code
> > tree. The calls to register/unregister_reboot_notifier() were in the or=
iginal
> > introduction of mshv_root_main.c in upstream commit 621191d709b14.
> > Evidently the code described by that commit message was not submitted
> > upstream. And of course, the kexec() topic is now being revisited ....
> >
> > So to clarify: Do you expect that in the future the reboot notifier wil=
l be
> > used for something that really is required for resetting hypervisor sta=
te
> > in the case of a kexec reboot?
>=20
> While that commit wasn't individually sent upstream but all the code
> from that commit did land upstream probably bundled with other commits
> when the mshv driver was introduced. So the reboot notifier is indeed
> currently used for resetting the synic correctly during kexec reboot.
>=20

Indeed, you are right. I confused the "mshv_root_sched_online" and
"mshv_cpuhp_online" cpuhp states. The reboot notifier removes the latter,
not the former.  And the latter does substantive cleanup work on the SynIC
when the state is removed. Apologies for the confusion.

Michael

