Return-Path: <linux-hyperv+bounces-8487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI/ZMyi+c2mHyQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8487-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:30:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5A79A99
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3273305B471
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E628D8DA;
	Fri, 23 Jan 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kbkCgQ+V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012074.outbound.protection.outlook.com [52.103.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BE28D8FD;
	Fri, 23 Jan 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192892; cv=fail; b=Oe+ncVWSEMZaIGIpKFu8X31joLEuna6rW3LHklQg03TUsG6uQuofqhXJYIIiUlHKnPA3eRh1GGbFO3i8MfcQ5hQ2irN1W7+uQakGqRIXY04ZYWdEywhih4gOHGZbjcl63ompXHUiJeCXYOAyhNcWyND6hjYDzlUR5U+JgPYuilI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192892; c=relaxed/simple;
	bh=cWttfYhQOMO4sRwBjwgXOJDaATPIXVhvk0hIZXgzY6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgvo0m4/WfWugDm+qhqJwCfslkG1K7SCGfP6ya33zX6+l5hI0jLXJHHCTSfc5ZrytcuMmhe3eUZK8TCPT/6HbIkI0HFI32y73+JauTjTybLt4kPat8/YKMqHbXhFmoCSiyN07GQdnXrOavJ05OmVrQbZ72AHTAxI7/33JsRaST4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kbkCgQ+V; arc=fail smtp.client-ip=52.103.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbycO4nB471YEgxs5OTa4ehrokI07UOwjhnQ4kcL8yTvmTjekY4UrSPIhWLxm8zOdWYX6sXwJ2YveidEHg1Cplyfe19zTatD4vThXg/WZNe2qmekAwGHK1QZMNRWF7dXdG2mudwoQIvoxokp9bWkbJ+D0AGGyGmeT71uzbo458lqCSNKu/ZLdHO7m/gMHNg/1c+w19FMLnKu5zf83u54i0qr/dH35rZiXiHUfnZvy5H7aSg9kAQSqOl5hPjv4oKpoGZMB0OoUpQL0Ii1K3aftB89pwBLNjB3R2WJHgQbCU0EenBK6PODb/warbW0n7Kt3St9gsUMA5AuKi/A+CJSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8+9HE3tgQUPGP+vrgXQulyLUKSmsjX4M8mujypjJQY=;
 b=OqdPqhBvLmQYyLAmxDgXj5Pyp+alUl3NVjp2W+GNk2AsvRTSea9anKyvfy6+a+V7MWNBuqH2Y0hDqwi5kQ9ibId7Ac+E4C+ti++Ydte7brrijre9tWfFz9poApOYfvGqPKjoA/lggCYSfI2wvjcQbhGKaDb71b/nbQt7uThNGm4SSrbN79kSajJjzT4Hw7NplUTjNcqxfFmFwgsbtMnO5DJPFpoyNfx9E1sLptC0B/ftGtXtvzduettgOASavFX/wZEOLbG/4OllATymo/YqhktjCCZY6ZooaVx0WODMPVco1vviA82BguusqlRZ05IQfU7EU9eZ8fijw1LFEhZeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8+9HE3tgQUPGP+vrgXQulyLUKSmsjX4M8mujypjJQY=;
 b=kbkCgQ+V/wrNXCweC7oEw0qd2TUljFrZWl6zpvprRFKynKYOnlUxt5FSrJkr1wYSylxTXE9MQbEC5L5PGbTpfyuicm2Ju0h4Ads5QwGjLZfEL/zk7GRj4aS1qsxY9EpTFgcFczuMboh0PC1BRp+7Zm2QHu5QW847i5wuWcK8FhwCOkba8KM+TGeddash9MEo4foLq1EPLbkcucHS1iJSMlBxDj/QHVuGxuJDKiWIMsBmhzn8nBG/WRYj3HXGhWWWhOFH1ihRoNWkk/b0aRv01SGErnTsoefFPJ3pZez1W8FRRX6ZU5bnKyGN2EF1ATXkG4DZM4/5QnvmoJjgutUfDA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB11038.namprd02.prod.outlook.com (2603:10b6:8:293::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Fri, 23 Jan
 2026 18:28:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 18:28:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Matthew Ruffell
	<matthew.ruffell@canonical.com>
CC: "DECUI@microsoft.com" <DECUI@microsoft.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"jakeo@microsoft.com" <jakeo@microsoft.com>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"longli@microsoft.com" <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index:
 AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwCAAMhuoA==
Date: Fri, 23 Jan 2026 18:28:08 +0000
Message-ID:
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB11038:EE_
x-ms-office365-filtering-correlation-id: a091076f-7014-44b0-cc63-08de5aad2884
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j29AnTtbLKjpqQ4tPEUmeMtb+Ho6HadzQP+kN1yzaexRjN2FNTq/ZrGrwdTEKlbHrWPGZEFS6DvlM9GUSSvV0GO6OdIwM1DhX7x3Qr5haC+O089LgLbmj0PBjqGtlutoGs+szUKDaBYoPhNqDhOTH6I9CNq+si5FRzifnm09PKRhUxoXVUoa5qnATtLxzadjYq0gGWt76Bn30TynldPTu0FKSvELOvPw6Bsc53wwOwHpg2lzwHtxI2xTE5gr4FMU2YqPmXpcOGhmtX/ext6vQVkiwRISn2IR7Bt2sW9jBG7LTN6m7/gWg1GhyMzOJmp8jIVLXf0wPuPJ0uWrE8Ny6JUah9p0zieSm+dlOhHbzoje89A0FZMH28KiWOJE5MOD04HQbRa8od4lR/mv1ff+NmzxlpEpR3Obk3596EPae/g4nUcV5rDtY4q5gHjyih3nEJn7T3AWIu6b+bQe0ciBnxMXV4570HMVt2qHq/MbqfTVRrfl31nz+VpnQ5N/TCSSzKFgI3PZPbunEPje45s+U/ARNOnqjQe9kEXxmLpewCgNzkOV/v+rLbb0N8/vnZRF495rJv/M/RKS0sKI8sVJRkW01H/Fc8o5n7eFSWPyZ7lE1VB3LOJXzYVhqdl8qqHhR/Y2mOGVBnSGF9r/jWPeFopUtlPBKVNfUxe5uYE5xEnFV52k2IGaL9LGudwDzqZrOzjJB3BbBMFPdQOsTer7rQ1ooIYWg3Tl6jttw73tYuShFN4iWFqYR273lnMnYCBM/BRZ5U7rjuIWsDZpismH2SYOcAZA0OEt6yvg7/WRxk8KBqiEwzUokxYS
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|31061999003|15080799012|461199028|51005399006|8062599012|19110799012|13091999003|8060799015|4302099013|3412199025|10035399007|440099028|40105399003|102099032|1602099012|56899033|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B2VAcchGtKKhDenEsWLU2TBYpL7jINFQYWE3AMrcf/ZPIff4kjamaPaLwd7C?=
 =?us-ascii?Q?0s6iG3JuV21IZLifAohkD9+KvQNIPuAs0amZkogPVXEbqMmz9EXFWWNhGRMn?=
 =?us-ascii?Q?kWf7Eb1qVzROMe+KtQPjSD7lOCIbrm7UwkjAoBfYfpsEFyhhoLfN0i+2ANqq?=
 =?us-ascii?Q?aHyKb0B6jnraoeCSn6+o2eyEaCErujh/+kKxeUQy5LxrcMA0xP3IS7zuoO6H?=
 =?us-ascii?Q?NLjVHa4fgAzqYiOITN7tBw+BUqQhJQe/pO45feV5qcPkkYzrYsWl157rzhe1?=
 =?us-ascii?Q?f5Rbl/z7/1XeVY2/8ZHbGuYnNbt7L8rCH0HDhyBSuGUTT1W03tXr+Yb7Io/A?=
 =?us-ascii?Q?yIiNH+h1QJLwB9Se5+Hybkq0ALW9g3Gjf5YCJ7PNRxJuQ/oa5aTX5x57CHqD?=
 =?us-ascii?Q?qkN/Xk4+yT66mC8jtTsWqSL//sbRzH+VqtkRh3pBRAF6pO5f8WM/TWiZlVeH?=
 =?us-ascii?Q?cvh0g62VApn84hMaHBT/9ofY7cYLXTSL4pxDtGOsYsb8JohpsZZ375SllM3+?=
 =?us-ascii?Q?VdcrnfgOETN+Gu/xKOZBTePex10S/r+7qIPLH5+ilyvpTPI8gnrJ1AcAuB6w?=
 =?us-ascii?Q?dOFneDij+jeX8cZtMUKtS3ZaWiCaVPmeQwcyyLcQRo8onscATgUatH31OUKQ?=
 =?us-ascii?Q?zxQu709vrYVka5VPwWSPdoPNf5/e4Id1rfYwcxNMOo7lNnjR6BstiodPBn6N?=
 =?us-ascii?Q?PzVwA1/nKo77XZsZ8/xD4t75bBaqokJCzzsNevMjNJhDRTvLKukDA8AqNt80?=
 =?us-ascii?Q?0XboRVlLgdsWZkVMwTZh56gcvzdgXtSOoA++2xuaj2HciaylXcOLIuPMX1a+?=
 =?us-ascii?Q?rnskowR+zO40CT4rPKl3FNiX3r8GmIYxs2rKJT1pz5gAndnLFC2OHsRUQnP4?=
 =?us-ascii?Q?3WQnYeqvVzi8wdigeiNnsPgGjb9u6WOtZTOYF6InN1DLxHVtoWbHD1U8nq3E?=
 =?us-ascii?Q?EpfvwQ66ce6YhESd5IqkAsiIejb3MARF5x1zd/QWLoXOf9CuSbijK0r6E9Gr?=
 =?us-ascii?Q?ocDGraZHiF5/Eynem33MxwtbooBsXkVrG6rAjAYe11RZHfhfj0LeogsrokYo?=
 =?us-ascii?Q?/eUGs1ac7h8yk066BzGiRjSwJBuha826G541xjxXFQE99oOQfbVzKppZbj2Q?=
 =?us-ascii?Q?Qs+vrkflSjYSP36LRypcQJ4jaO5OIDfqqFk/yv8sSjVMRRReucBkWKwFO0pv?=
 =?us-ascii?Q?k8ukMvgPZ/wIoCSbMzU4WoChq/jaYP/b58CHKWozghrpx/tuPDG1WAT2nlm+?=
 =?us-ascii?Q?u0voRjceGRqkqqR40Kj1YjQyePdU8yl3yua6Duc1WLmD4unUy40RosyYtYXI?=
 =?us-ascii?Q?WkN8rn4feDqfVq4gso5X4kzuyGATzsX43ATLWk3WXdfxR5iTc24RSFb/ooS0?=
 =?us-ascii?Q?eAv7gJ2jgBROCVqFGkOaxJTvzleFG8NUcessk1R28uWA0TzubQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AV08R6ASOC+lyyAJPzQ+AQY/xFKp9mWvgD2XedSEJbDTXBdVM9D5ithjkKGM?=
 =?us-ascii?Q?jzx5Y+yLVvlLxiee60vepaGWlJkQELkYDr+zKVK7oOp2PbOfyqIZf+3Rcfqa?=
 =?us-ascii?Q?d9RML5iAmQLtEM5I32UMhuwgI0La+lP8cRs27ena5pgsrNHOXpZqwOqKl8dG?=
 =?us-ascii?Q?2uTujVNQLqJd357gYmnA6Aw8W7LGTBwDAckilIPHv4b4dj+ruv2T3DW7TfxL?=
 =?us-ascii?Q?GqrRNcG7/vZd32dNVH3AKAb+TIZwmscYM/emV1/2tFg7DcjliC+yj2K9skAS?=
 =?us-ascii?Q?AZklDLkE/6v9HZrLxIcxCx/WQD66Xaja29/MusBSIW0GMXy/ms+kxEJIt8j+?=
 =?us-ascii?Q?zlf2Qyj8X6wYmm/cwAypq/OwAJzuaSZALr7rSsvuMtqhRSBd+/lhzOEaURMx?=
 =?us-ascii?Q?yyZ6UEmy0+gFVvRJAtXIEtrB2a22q4Yx8qD+VgT4lnHdOhcJ5su0n353Vtax?=
 =?us-ascii?Q?oWEqs5xlH67dgnkO/HbrMdH2UxgnpxvH+pJ0Gmm2HxIQxzQoJoJV6Fi4HqCO?=
 =?us-ascii?Q?rQh9ja+acObmLVlMSgb4o8pT3At/SDtsNsoH4Rsnh7zc6xr5t9k037xD6ezc?=
 =?us-ascii?Q?Yom5sZg5bawU693vxeWjbJTqJVzl/44A7cUwCpNvMmMS5CeGzWwUgHDTq7OK?=
 =?us-ascii?Q?N8bC6vKDXsJ2SZo4pdmfEMDv7NujU8acn5DWhuSHEFlTulNGrOvXB7CEEv+/?=
 =?us-ascii?Q?qnb8JEFVdPk7a9QlYu0lxcVllyAUsNEH6sOLau27b7uKRrQeXl8SdM9a192G?=
 =?us-ascii?Q?q4fcMSZvv2kfxsam8kaUHdEdzp8cD1Ed80JYp1e9boyc/gft17uUOIDQurOc?=
 =?us-ascii?Q?URnoj0T07bTVo30vD+cYj7wvP99hV5vCV3CGla5KbXA6/0ZImpp74zsT+0UA?=
 =?us-ascii?Q?7QFahyuvqKwb7WHlRVU/CS7NjNmnRbES17h4Krw/yykDEBPPZvOo4tfIYtiV?=
 =?us-ascii?Q?H6cnb0noEChcIQUegSdgNbITJ5zOFc/Ak9SYqVNG0T5/EbAQe/KxJCRJHfEb?=
 =?us-ascii?Q?4NGme/k1LtQl39gXi4sQD7yQlGCt/uqFrlR5ARnaH21A4UVIODiIqsVXB0c2?=
 =?us-ascii?Q?ibY4yYhevGW5jXzx203lhzviItQigIUe78h9vHVto00TyiWRH3goAwewA4/q?=
 =?us-ascii?Q?s/Q4W4pLDx6aClD49TdM8iK+onh5Q+zucUN/FHbljyPER8YJJYH8afWvUZ/X?=
 =?us-ascii?Q?QH8NdKlSHeDLQeW/S5sWPx2zI6sQ3IzNlQiEh8ufuu69M0nuv0oaJTJbJs0S?=
 =?us-ascii?Q?WM0fSKMVgT5qXwh29HhYUaDXJtJKNUS5FJQnJMPzfCFXprnqVShcDpmNdObG?=
 =?us-ascii?Q?hbZ06PE6NWmVxio00HbOGJM2bzq71nz8kRyvze8+ncYJtftZ66QnRXFIxvP0?=
 =?us-ascii?Q?HIcuEVI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a091076f-7014-44b0-cc63-08de5aad2884
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 18:28:08.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11038
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8487-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[outlook.com,canonical.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 34C5A79A99
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, January 22, 202=
6 10:39 PM
>=20
> From: Matthew Ruffell <matthew.ruffell@canonical.com> Sent: Thursday, Jan=
uary 22, 2026 9:39 PM
> >
> > Hi Michael,
> >
> > > > I wonder if commit a41e0ab394e4 broke the initialization of screen_=
info in the
> > > > kdump kernel. Or perhaps there is now a rev-lock between the kernel=
 with this
> > > > commit and a new version of the user space kexec command.
> >
> > a41e0ab394e4 isn't a mainline commit. Can you please mention the commit=
 subject
> > so I can have a read.
>=20
> It's this patch:
>=20
> https://lore.kernel.org/lkml/20251126160854.553077-5-tzimmermann@suse.de/=
=20
>=20
> which is in linux-next, but not yet in mainline. Since you are dealing wi=
th older
> kernels, it's not the culprit.
>=20
> >
> > > > There's a parameter to the kexec() command that governs whether it =
uses the
> > > > kexec_file_load() system call or the kexec_load() system call.
> > > > I wonder if that parameter makes a difference in the problem descri=
bed for this
> > > > patch.
> >
> > Yes, it does indeed make a difference. I have been debugging this the p=
ast few
> > days, and my colleague Melissa noticed that the problem reproduces when=
 secure
> > boot is disabled, but it does not reproduce when secure boot is enabled=
.
> > Additionally, it reproduces on jammy, but not noble. It turns out that
> > kexec-tools on jammy defaults to kexec_load() when secure boot is disab=
led,
> > and when enabled, it instead uses kexec_file_load(). On noble, it defau=
lts to
> > first trying kexec_file_load() before falling back to kexec_load(), so =
the
> > issue does not reproduce.
>=20
> This is good info, and definitely a clue. So to be clear, the problem rep=
ros
> only when kexec_load() is used. With kexec_file_load(), it does not repro=
. Is that
> right? I saw a similar distinction when working on commit 304386373007,
> though in the opposite direction!
>=20
> >
> > > > >  	/*
> > > > >  	 * Set up a region of MMIO space to use for accessing configura=
tion
> > > > > -	 * space.
> > > > > +	 * space. Use the high MMIO range to not conflict with the hype=
rv_drm
> > > > > +	 * driver (which normally gets MMIO from the low MMIO range) in=
 the
> > > > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the frameb=
uffer
> > > > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base=
 being
> > > > > +	 * zero in the kdump kernel.
> > > > >  	 */
> > > > > -	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -=
1,
> > > > > +	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4=
G, -1,
> > > > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > > --
> >
> > Thank you for the patch Dexuan.
> >
> > This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
> > booting V6 instance types on Azure with Gen 2 images.
>=20
> Are you seeing the problem on x86/64 or arm64 instances in Azure?
> "V6 instance types" could be either, I think, but I'm guessing you
> are on x86/64.
>=20
> And just to confirm: are you seeing the problem with the
> Hyper-V DRM driver, or the Hyper-V FB driver? This patch mentions
> the DRM driver, so I assume that's the problematic config.
>=20
> >
> > Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
>=20
> While this patch may solve the observed problem, I'm interested in
> understanding the root cause of why vmbus_reserve_fb() is seeing
> screen_info.lfb_base set to zero. It may be next week before I can
> take a look, and I may need follow up with you on more details of the
> scenario to reproduce the problem.

One more thought here: Is commit 96959283a58d relevant? The
commit message describes a scenario where vmbus_reserve_fb()
doesn't do anything because CONFIG_SYSFB is not set. Looking at
the code for vmbus_reserve_fb(), it doing nothing might imply that
screen_info.lfb_base is 0. But when CONFIG_SYSFB is not set,
screen_info.lfb_base is just ignored, with the same result. This behavior
started with the 6.7 kernel due to commit a07b50d80ab6.

Note that commit 96959283a58d has a follow-on to correct a
problem when CONFIG_EFI is not set.  See commit 7b89a44b2e8c.
If there's a reason to backport 96959283a58d, also get
7b89a44b2e8c.

Michael

