Return-Path: <linux-hyperv+bounces-8484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wANINResc2nOxwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8484-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:12:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498E78D7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2127A3021707
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B8296BA7;
	Fri, 23 Jan 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZgumA/1Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011090.outbound.protection.outlook.com [52.103.23.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C122D4C3;
	Fri, 23 Jan 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188187; cv=fail; b=QptVFbhgyOUi0F2zr04EB2830PaCIc3FGvDgXbXd2oMITkTQLZHBhW2+YTqemz3HrOetQ6X5IzZQ1gsGnejWD4wTT9r4rnoQs08oxGnAPSwkEZBPVPqzhI7nwzU3EGpfHQc+R91t1MkPKrzZWL+EY/4rYDpBLciQHXMr/6BkLLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188187; c=relaxed/simple;
	bh=DZ5cjIJUe4GF2at0rTkK6zmdiYf99MZ+RowpDf4JWHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExzZyzkagoTk+kt0i2b6OV3ejVwx3pulP0u24+dVdYoDubQ3PPc6Ly57cOlmSJPAzOdEa+C6IqWTIUkyz3UXL+9c+X2HsBcoiQz5HUp7YtwMcmslMO0B2/wXH09IMTPf5HMqFP+tKpZEY/M1+6+kycRQIi+Xcth3fOy/kfeIi9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZgumA/1Q; arc=fail smtp.client-ip=52.103.23.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU2U5MGQ/TF0YTAOKVW5ohlrwVq4Pw+jdYh1T6/pauKV6PEbj/rTTKUok/NdGkM6tm1XwM3g1lzD52Hm3jHQfWCshkrqi8EoZwGJ3jC7ahY3cciabpK1qjAeIxhBHVzKe3tRXiFpgFG7NZKsgcO4a6tyZwOnPdKidK9QrqBv71Q+UyA++lb/O5tckEakzuQGo4yL66pVS2o3TvRSNhZM0ulidXBqF0Yqgm1T5CNtoOnVQqWdLikDYgjM2Zdk9HAz79zAZLCj9TFDUDWMqf37O3lEIznW+UZC9Z/bRhLp7b23t24vreUJeutpKommOXtGE/rMWft2S9YAzPNizQkGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns2KVahDc9p9FaFw91h2U6LpFLl/UMU382OR8+KuvCU=;
 b=BiHAK7OScn6kWUJA/7VRCDbTlN59JGWj0apmCJvSD0Z+eyGdLvYteu5sfBv7q1akT1CVkfdbogyG0LMaZQLuSbSTeZLn48DrEGnOTz+mMoWksGjVBnxeITgtnKW3kmESYf5uhwrGCbDfKB+Ydm7XNVt7JJ8bd7kTzGB+scVcpwXoe9uHNGUS/h/NGJNu9QUm50BWW+xTg2vYiKIMD/pA/pKSO0mBlVloX14zzp0/gu1un2ls/QMrzKu1l/mvqTpovsBeVhLA5B8FBcCSw5U/y+1R209q60FN4iTdVhmajy+MP87alRGOQ6aCd22CIaUdhjsQpHYsG3kzETP27nSZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns2KVahDc9p9FaFw91h2U6LpFLl/UMU382OR8+KuvCU=;
 b=ZgumA/1QNJV7eGYHtuC8AcKCMbnUrEB/doIg3gVzN1T4Xh9dFubbGYwT5HC5VyKQSkQVQH6T4f1Tryi0MucbTR9NlmUxSjZHt4kw6MQnBLnd3ZElnejmlMDrvsIdiarnj+uzskIiBfCcxZ74J+eJg+gM+7A2MF53y563uETQx5feRb0eh1oiQ0UGrY9r2JkNQaz8hxJ5DiIxgfuVj/pIfe8zqJuu0ylau7wegPgL1qyKZ/Wx95EDrh1h05Mvt/H5Ntqc3yanS2APQte2aMLqC6gXV4TSP0f9anmjugpeeEdjtsDnI8WlVr7+CftM2o6OXgDI7FJiPbG3snreFhSWug==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8355.namprd02.prod.outlook.com (2603:10b6:a03:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 17:09:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 17:09:39 +0000
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
	<paekkaladevi@linux.microsoft.com>, Jinank Jain <jinankjain@microsoft.com>
Subject: RE: [PATCH v4 7/7] mshv: Add debugfs to view hypervisor statistics
Thread-Topic: [PATCH v4 7/7] mshv: Add debugfs to view hypervisor statistics
Thread-Index: AQHcix9nCnBg5jeOiUCE+CULD/2xMbVfPNtg
Date: Fri, 23 Jan 2026 17:09:39 +0000
Message-ID:
 <SN6PR02MB415765A8221B8F6270ACEF1DD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-8-nunodasneves@linux.microsoft.com>
In-Reply-To: <20260121214623.76374-8-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8355:EE_
x-ms-office365-filtering-correlation-id: 615d99e5-4505-4a6a-f13c-08de5aa231b4
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyO+K31TYcDJnS3Nb0QmDRHVtnCESXEAihQk+PDfT0ZJCf2LiXBKp4KWWDIi84gWKupdzyajNMnGgSwOcMbWPA5aj+wXPrJhpcHh3rgDikmZ587nhL9tY/7dw2qWfBQasKKGxTSAm3AkDc8AnZjmyQqtIc6oAcdxeFvoe04qhHdBo0HYQ0NImnEVJdFn0zs9yu+4DyaSDTv7gxvHFySTOnyejTnSsLdqiVdfdxdj9u0AfcWV5Xl+oM2viX7RZReMtjwVTbOqwReLJSPcdZ2n3sFdn3d1GkZrBAL5r3765osJ3r3/aRNwG9ZUt/Q2mHKILoBq0hAMyCE0wsfkqDmyJFkZNawFxInG3K4ssSDmflzVfkSPMpiu95D1SZ9FzrokXvBso0wk7znOEuc4ohXsMrClwrfFXibJQZODDaKBGhVYExOPmn3xxwTMLSPhadTKf1IQvh/Ai0Fr5B8zHv8x5dVjSOFC5tNqaHqbVkLQY/GiHCmm06O7/rgoHwLseeambMkOdpSlE/8eIzGu3lDy0UYK2wwSyehnMXmnsi413PAcONGL7jJNjj4FCknMK6ubR7tH9Q6jpnn9vegEuMPDlC1grs3SvL9sX0c7uteTojrKg4n+acxzpgp4LFhrCBL6y6b8UH3uekZGWQb1icTX9vSCqvkmM94o3cb8NsPYIAzAYjv4vWX/yfxi3E/HNrQLD0r7WtkfEfxLYEw9UyykqGrk5MT4Gl83Z0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|31061999003|461199028|12121999013|51005399006|8060799015|8062599012|13091999003|19110799012|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?APwey3uP1gWf0wPS1WZQIj3FmB0hfTH7cw9MkvqieOi21ZI2udmAPkFlMYxb?=
 =?us-ascii?Q?XXDlnisTXBvTOwtU/wJ6UB+6Ajb2xIMq9fnr/RnpHjEL9i3IyL+7uT2oCDeu?=
 =?us-ascii?Q?LJ6vxUrAkgMG/KxGUTv232hdmNMxgxUsw6GryDihSvvNbOVuMbWSS0InbIok?=
 =?us-ascii?Q?PjiIDoUfswroki1G5IMCjx8p5HYcc+TvWIhioee6gsdctdk7yxWE8vq1RV3D?=
 =?us-ascii?Q?6XpAeVgBDB71qP2V2yH6PSbgkZyHzbxdv8+TPqXrmhH/ivFxlNO3miidi/Gb?=
 =?us-ascii?Q?GOzigPyOTVOT/zVz7dtjaZDLjMRIRFBQqQo+/zQsg1/nPEsvwX/KSAxLFK6B?=
 =?us-ascii?Q?c+dUAeD+zyWIKWIkxkNzeBYBq5QwogQ0P4Nlut16/tx4e/khgSa7LuAhdq2o?=
 =?us-ascii?Q?qlHw8dunibJsLsNIA2RLlLwX6BDSJSKq86QRisGrTtjEMLbQqhAJMTEFpN75?=
 =?us-ascii?Q?P2fQuY+pPF5RNaMc9lVBbdXuqkIEiINU/u/0dPlQyn4B8sJmXK2vUR6XC5Wr?=
 =?us-ascii?Q?DnYQQ0RR8vzOl9wUPwolT8QKGK5SpfFNzhmoSbRo5qv25q79QWmHFbS/fQpM?=
 =?us-ascii?Q?gV1WJomoSCuZM0eVbtFgL4VivfpscZL+oqIQ6XHC4Cnj1C8Cc806euz7KYIF?=
 =?us-ascii?Q?OI++e16AVw3gvxH1mP/ovHU2Xqdizyta6Qj4qNPrrAOsErOh+A+9DjDlqp9+?=
 =?us-ascii?Q?WT1OSb/6SneT0nZk6ubK0qb3c5jNO3vDMGUw3aVY+yHps+L9bNfNLvtujCst?=
 =?us-ascii?Q?PfLk/28+64PuHRj1JMH7kS//eAXvS+1aKKYDmzM1E7gv1+LxSwQeCBr/G7Jt?=
 =?us-ascii?Q?61d8CgsVIfdYWOo6zbEW8ElIScaLxyGxWOJtQ0snEXT8zxW+sdXeuXB+HtMb?=
 =?us-ascii?Q?7sKvH9oO+m7w1DQ/3cJ/32zOgfmGs2cCllUgefIgt313fonBbpUJgF2oqokv?=
 =?us-ascii?Q?eGx0nMwcsGwSL6VK9vXl/dOZUo+0OzpKiwGOaEYlYDxZgnnsNNVXcQ6whGIm?=
 =?us-ascii?Q?u7bUjoQWUGj/CEc4Yi/QiJzFxAJ5bAP5kiiypDKIKqo9URXVUyCxI1V3ftFP?=
 =?us-ascii?Q?B8qFniAroxf80xoAcQcGLOoxuh/4J54ZBByLAYP2iwbCc6EuHXWQ5kGuyY+c?=
 =?us-ascii?Q?PToUFFfVlyFi5HyFdvu8DiGQwzkJUeETLSAKk9YBBx8DI3Yk/4nb9UBf8DIn?=
 =?us-ascii?Q?uxuCvENnt8EcRvdnz5eaSes3hwWjmJEnVXzbTt73BZzs2is7txp8vglmbDId?=
 =?us-ascii?Q?C7ayI+CzJg3n2XnTFwxMOKoFKhm1rWKfC/II5ZIJZ8tYTZwQ0nUJ1Q+iy1xu?=
 =?us-ascii?Q?I9I=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BH4UV6CC3k6qaNN7xBS3qUvjfKGWECAHdsTOr0I2wv7gBjGgYngykT58by7Y?=
 =?us-ascii?Q?5Ttx+uXTnch0j3tSg7C7lyV5MPeMNUo3M4ghZ60B78M3Z6LlMScaV1K5ELpu?=
 =?us-ascii?Q?sozjIsaNTcfk3MXtxND7YaSKbky0cOwHx60dbHcjVx/8n1+scrdQmQd93Eug?=
 =?us-ascii?Q?IPd4OGAuAvFkToKO8Uk2dBlDfu+1zGIg5htr1TjnYY4Gp+h0sUGVc+uI4ywr?=
 =?us-ascii?Q?E6TuJqB9CwR0XsZedVMWSmHjHmGC5LSH0C5dTjbGWGHvMrVSQw3/mxdN0rvE?=
 =?us-ascii?Q?BXHVA4TL1gpeqbOtzwfH83JNRaN/pfRGz/EnR01rTcwZ1dyNjUmfkvAVV2J8?=
 =?us-ascii?Q?On35mXbHQPLWoNVucyY+cUCIxcYlMZDQc7dpgqT/CqGEu7GbEQbq8ItOpxpV?=
 =?us-ascii?Q?4s5lMlQdtQfVje/emTJ9pLV0d3heHciHaOKecnMpYdFngQJsAloXGSrlW8I8?=
 =?us-ascii?Q?STmeSsB4Du8GO7BXUBuFgI8DpfpZlcM7vca27qE3DfRgLWI04vJnFf5nszcU?=
 =?us-ascii?Q?9faMmjyi5xmwkTnJLYCWFG/fBpZnlHl7a2dpuycIUvbWv5xqB7IKQBpJb5h4?=
 =?us-ascii?Q?nVg+60JV45xMMUN2AkOMAyLA7SThX0A9ZfxkUeq870pwe1bK24WnNpf/i3rs?=
 =?us-ascii?Q?jLs4Y516CKFtIWvEjglNCTTALn08WlmWX6bYN5yElH5BAPMOkkgM10Q4BRok?=
 =?us-ascii?Q?fth/eMrMyvAAUSxkiPcuxzBr8Z24s6Zlwz7mxCyvvF9HLjHn2oXGT8LvnvSk?=
 =?us-ascii?Q?WZIxKCxNmHc1qAblGKlZrN1Bq27vKJotwPkDaT3JRnLbR5Ncnyllvp37xdve?=
 =?us-ascii?Q?cFDn8P5/y4QfZxNzKhZTpAEJ2BW5rWB3pLbCwbXRpQi1dyZ9m2UxUigLkLnv?=
 =?us-ascii?Q?IpxufIrYecjyuoaqnNEwGLRea/SJNKVaDPjOh0+fjgAb70OlayYcIuljA+/L?=
 =?us-ascii?Q?+/wrUF8PIAWzyJp5MoRrIt9NYUSbXXj1xhYXjbEPikfLY6P3TMf6fBXar/6k?=
 =?us-ascii?Q?ZPMWp/W9mipxg5gYdxNCENGmpB5QnZr20lovR4JypIe6eKSfBbTjimbul7N8?=
 =?us-ascii?Q?g0suxin4N3Su4VGSxu++DyoW2+F45FiR1AgdMziDyn3UcyXb/jWadmYJE2UY?=
 =?us-ascii?Q?G1F6NwiHpVKN7pY2wmp9sMBObXEpod+tJhDSKv17BlgF5ufk2WgCMM6vb7dK?=
 =?us-ascii?Q?swJzeJyizJKJgDOu1B0LXICVjspZXDRcA51nTCFUcM0a7douOwrhTXU/KXad?=
 =?us-ascii?Q?cfkVDHcy1PMsoScQG7dmCPOnYFPbmwwv/FFjNxZtapf7KK3L3zmTVXZInpKD?=
 =?us-ascii?Q?3f0NiS7zsk4wEom+uClsY22jwQBpHqyCRtayIQGPTvgA8GncUq1RKfSBIVvn?=
 =?us-ascii?Q?8O1D8/k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 615d99e5-4505-4a6a-f13c-08de5aa231b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 17:09:39.7629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8355
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8484-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: 2498E78D7A
X-Rspamd-Action: no action

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ja=
nuary 21, 2026 1:46 PM
>=20
> Introduce a debugfs interface to expose root and child partition stats
> when running with mshv_root.
>=20
> Create a debugfs directory "mshv" containing 'stats' files organized by
> type and id. A stats file contains a number of counters depending on
> its type. e.g. an excerpt from a VP stats file:
>=20
> TotalRunTime                  : 1997602722
> HypervisorRunTime             : 649671371
> RemoteNodeRunTime             : 0
> NormalizedRunTime             : 1997602721
> IdealCpu                      : 0
> HypercallsCount               : 1708169
> HypercallsTime                : 111914774
> PageInvalidationsCount        : 0
> PageInvalidationsTime         : 0
>=20
> On a root partition with some active child partitions, the entire
> directory structure may look like:
>=20
> mshv/
>   stats             # hypervisor stats
>   lp/               # logical processors
>     0/              # LP id
>       stats         # LP 0 stats
>     1/
>     2/
>     3/
>   partition/        # partition stats
>     1/              # root partition id
>       stats         # root partition stats
>       vp/           # root virtual processors
>         0/          # root VP id
>           stats     # root VP 0 stats
>         1/
>         2/
>         3/
>     42/             # child partition id
>       stats         # child partition stats
>       vp/           # child VPs
>         0/          # child VP id
>           stats     # child VP 0 stats
>         1/
>     43/
>     55/
>=20
> On L1VH, some stats are not present as it does not own the hardware
> like the root partition does:
> - The hypervisor and lp stats are not present
> - L1VH's partition directory is named "self" because it can't get its
>   own id
> - Some of L1VH's partition and VP stats fields are not populated, because
>   it can't map its own HV_STATS_AREA_PARENT page.
>=20
> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Co-developed-by: Purna Pavan Chandra Aekkaladevi
> <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Makefile         |   1 +
>  drivers/hv/hv_counters.c    |   1 +
>  drivers/hv/hv_synic.c       | 177 +++++++++

This new file hv_synic.c seems to be spurious.  It looks like you unintenti=
onally
picked up this new file from the build tree where you were creating the pat=
ches
for this series.

>  drivers/hv/mshv_debugfs.c   | 703 ++++++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_root.h      |  34 ++
>  drivers/hv/mshv_root_main.c |  26 +-
>  6 files changed, 940 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/hv/hv_synic.c
>  create mode 100644 drivers/hv/mshv_debugfs.c
>=20
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index a49f93c2d245..2593711c3628 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y :=3D mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o=
 \
>  	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> +mshv_root-$(CONFIG_DEBUG_FS) +=3D mshv_debugfs.o
>  mshv_vtl-y :=3D mshv_vtl_main.o
>=20
>  # Code that must be built-in
> diff --git a/drivers/hv/hv_counters.c b/drivers/hv/hv_counters.c
> index a8e07e72cc29..45ff3d663e56 100644
> --- a/drivers/hv/hv_counters.c
> +++ b/drivers/hv/hv_counters.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2026, Microsoft Corporation.
>   *
>   * Data for printing stats page counters via debugfs.
> + * Included directly in mshv_debugfs.c.
>   *
>   * Authors: Microsoft Linux virtualization team
>   */
> diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
> new file mode 100644
> index 000000000000..cc81d78887f2
> --- /dev/null
> +++ b/drivers/hv/hv_synic.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +/*
> +	root	l1vh	vtl
> +vmbus
> +
> +guest
> +vmbus, nothing else
> +
> +vtl
> +mshv_vtl uses intercept SINT, VTL2_VMBUS_SINT_INDEX (7, not in hvgdk_min=
i lol)
> +vmbus
> +
> +bm root
> +mshv_root, no vmbus
> +
> +nested root
> +mshv_root uses L1
> +vmbus uses L0 (NESTED regs)
> +
> +l1vh
> +mshv_root and vmbus use same regs
> +
> +*/
> +
> +struct hv_synic_page {
> +	u64 msr;
> +	void *ptr;
> +	struct kref refcount;
> +};
> +
> +void *hv_get_synic_page(u32 msr) {
> +	struct hv_synic_page *page_obj;
> +	page_obj =3D kmalloc
> +}
> +
> +
> +#define HV_SYNIC_PAGE_STRUCT(type, name) \
> +struct
> +
> +/* UGH */
> +struct hv_percpu_synic_cxt {
> +	struct {
> +		struct hv_message_page *ptr;
> +		refcount_t pt_ref_count;
> +	} hv_simp;
> +	struct hv_message_page *hv_simp;
> +	struct hv_synic_event_flags_page *hv_siefp;
> +	struct hv_synic_event_ring_page *hv_sierp;
> +};
> +
> +int hv_setup_sint(u32 sint_msr)
> +{
> +	union hv_synic_sint sint;
> +
> +	// TODO validate sint_msr
> +
> +	sint.as_uint64 =3D hv_get_msr(sint_msr);
> +	sint.vector =3D vmbus_interrupt;
> +	sint.masked =3D false;
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +
> +	hv_set_msr(sint_msr, sint.as_uint64);
> +
> +	return 0;
> +}
> +
> +void *hv_setup_synic_page(u32 msr)
> +{
> +	void *addr;
> +	struct hv_synic_page synic_page;
> +
> +	// TODO validate msr
> +
> +	synic_page.as_uint64 =3D hv_get_msr(msr);
> +	synic_page.enabled =3D 1;
> +
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> +		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> +		u64 base =3D (synic_page.gpa << HV_HYP_PAGE_SHIFT) &
> +			    ~ms_hyperv.shared_gpa_boundary;
> +		addr =3D (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> +		if (!addr) {
> +			pr_err("%s: Fail to map synic page from %#x.\n",
> +			       __func__, msr);
> +			return NULL;
> +		}
> +	} else {
> +		addr =3D (void *)__get_free_page(GFP_KERNEL);
> +		if (!page)
> +			return NULL;
> +
> +		memset(page, 0, PAGE_SIZE);
> +		synic_page.gpa =3D virt_to_phys(addr) >> HV_HYP_PAGE_SHIFT;
> +	}
> +	hv_set_msr(msr, synic_page.as_uint64);
> +
> +	return addr;
> +}
> +
> +/*
> + * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Control=
ler
> + * with the hypervisor.
> + */
> +void hv_hyp_synic_enable_regs(unsigned int cpu)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D
> +		per_cpu_ptr(hv_context.cpu_context, cpu);
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +	union hv_synic_sint shared_sint;
> +
> +	/* Setup the Synic's message page with the hypervisor. */
> +	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> +	simp.simp_enabled =3D 1;
> +
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> +		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> +		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
> +				~ms_hyperv.shared_gpa_boundary;
> +		hv_cpu->hyp_synic_message_page =3D
> +			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> +		if (!hv_cpu->hyp_synic_message_page)
> +			pr_err("Fail to map synic message page.\n");
> +	} else {
> +		simp.base_simp_gpa =3D virt_to_phys(hv_cpu-
> >hyp_synic_message_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	}
> +
> +	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
> +
> +	/* Setup the Synic's event page with the hypervisor. */
> +	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
> +	siefp.siefp_enabled =3D 1;
> +
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> +		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> +		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
> +				~ms_hyperv.shared_gpa_boundary;
> +		hv_cpu->hyp_synic_event_page =3D
> +			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> +		if (!hv_cpu->hyp_synic_event_page)
> +			pr_err("Fail to map synic event page.\n");
> +	} else {
> +		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->hyp_synic_event_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	}
> +
> +	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> +
> +	/* Setup the shared SINT. */
> +	if (vmbus_irq !=3D -1)
> +		enable_percpu_irq(vmbus_irq, 0);
> +	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 +
> VMBUS_MESSAGE_SINT);
> +
> +	shared_sint.vector =3D vmbus_interrupt;
> +	shared_sint.masked =3D false;
> +	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
> +	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
> shared_sint.as_uint64);
> +}
> +
> +static void hv_hyp_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +
> +	/* Enable the global synic bit */
> +	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
> +	sctrl.enable =3D 1;
> +
> +	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
> new file mode 100644
> index 000000000000..72eb0ae44e4b
> --- /dev/null
> +++ b/drivers/hv/mshv_debugfs.c
> @@ -0,0 +1,703 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, Microsoft Corporation.
> + *
> + * The /sys/kernel/debug/mshv directory contents.
> + * Contains various statistics data, provided by the hypervisor.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/stringify.h>
> +#include <asm/mshyperv.h>
> +#include <linux/slab.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +#include "hv_counters.c"
> +
> +#define U32_BUF_SZ 11
> +#define U64_BUF_SZ 21
> +#define NUM_STATS_AREAS (HV_STATS_AREA_PARENT + 1)

This is sort of weak in that it doesn't really guard against
changes in the enum that defines HV_STATS_AREA_PARENT.
It would work if it were defined as part of the enum, but then
you are changing the code coming from the Windows world,
which I know is a different problem.

The enum is part of the hypervisor ABI and hence isn't likely to
change, but it still feels funny to define NUM_STATS_AREAS like
this. I would suggest dropping this and just using
HV_STATS_AREA_COUNT for the memory allocations even
though doing so will allocate space for a stats area pointer
that isn't used by this code. It's only a few bytes.

> +
> +static struct dentry *mshv_debugfs;
> +static struct dentry *mshv_debugfs_partition;
> +static struct dentry *mshv_debugfs_lp;
> +static struct dentry **parent_vp_stats;
> +static struct dentry *parent_partition_stats;
> +
> +static u64 mshv_lps_count;
> +static struct hv_stats_page **mshv_lps_stats;
> +
> +static int lp_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page *stats =3D m->private;
> +	struct hv_counter_entry *entry =3D hv_lp_counters;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hv_lp_counters); i++, entry++)
> +		seq_printf(m, "%-29s: %llu\n", entry->name,
> +			   stats->data[entry->idx]);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(lp_stats);
> +
> +static void mshv_lp_stats_unmap(u32 lp_index)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.lp.lp_index =3D lp_index,
> +		.lp.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR,
> +				  mshv_lps_stats[lp_index], &identity);
> +	if (err)
> +		pr_err("%s: failed to unmap logical processor %u stats, err: %d\n",
> +		       __func__, lp_index, err);

Perhaps set mshv_lps_stats[lp_index] to NULL?  I don't think it's actually
required, but similar code later in this file sets some pointers to NULL
just as good hygiene.

> +}
> +
> +static struct hv_stats_page * __init mshv_lp_stats_map(u32 lp_index)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.lp.lp_index =3D lp_index,
> +		.lp.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	struct hv_stats_page *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR, &identity,
> +				&stats);
> +	if (err) {
> +		pr_err("%s: failed to map logical processor %u stats, err: %d\n",
> +		       __func__, lp_index, err);
> +		return ERR_PTR(err);
> +	}
> +	mshv_lps_stats[lp_index] =3D stats;
> +
> +	return stats;
> +}
> +
> +static struct hv_stats_page * __init lp_debugfs_stats_create(u32 lp_inde=
x,
> +							     struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +	struct hv_stats_page *stats;
> +
> +	stats =3D mshv_lp_stats_map(lp_index);
> +	if (IS_ERR(stats))
> +		return stats;
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     stats, &lp_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		mshv_lp_stats_unmap(lp_index);
> +		return ERR_CAST(dentry);
> +	}
> +	return stats;
> +}
> +
> +static int __init lp_debugfs_create(u32 lp_index, struct dentry *parent)
> +{
> +	struct dentry *idx;
> +	char lp_idx_str[U32_BUF_SZ];
> +	struct hv_stats_page *stats;
> +	int err;
> +
> +	sprintf(lp_idx_str, "%u", lp_index);
> +
> +	idx =3D debugfs_create_dir(lp_idx_str, parent);
> +	if (IS_ERR(idx))
> +		return PTR_ERR(idx);
> +
> +	stats =3D lp_debugfs_stats_create(lp_index, idx);
> +	if (IS_ERR(stats)) {
> +		err =3D PTR_ERR(stats);
> +		goto remove_debugfs_lp_idx;
> +	}
> +
> +	return 0;
> +
> +remove_debugfs_lp_idx:
> +	debugfs_remove_recursive(idx);
> +	return err;
> +}
> +
> +static void mshv_debugfs_lp_remove(void)
> +{
> +	int lp_index;
> +
> +	debugfs_remove_recursive(mshv_debugfs_lp);
> +
> +	for (lp_index =3D 0; lp_index < mshv_lps_count; lp_index++)
> +		mshv_lp_stats_unmap(lp_index);
> +
> +	kfree(mshv_lps_stats);
> +	mshv_lps_stats =3D NULL;
> +}
> +
> +static int __init mshv_debugfs_lp_create(struct dentry *parent)
> +{
> +	struct dentry *lp_dir;
> +	int err, lp_index;
> +
> +	mshv_lps_stats =3D kcalloc(mshv_lps_count,
> +				 sizeof(*mshv_lps_stats),
> +				 GFP_KERNEL_ACCOUNT);
> +
> +	if (!mshv_lps_stats)
> +		return -ENOMEM;
> +
> +	lp_dir =3D debugfs_create_dir("lp", parent);
> +	if (IS_ERR(lp_dir)) {
> +		err =3D PTR_ERR(lp_dir);
> +		goto free_lp_stats;
> +	}
> +
> +	for (lp_index =3D 0; lp_index < mshv_lps_count; lp_index++) {
> +		err =3D lp_debugfs_create(lp_index, lp_dir);
> +		if (err)
> +			goto remove_debugfs_lps;
> +	}
> +
> +	mshv_debugfs_lp =3D lp_dir;
> +
> +	return 0;
> +
> +remove_debugfs_lps:
> +	for (lp_index -=3D 1; lp_index >=3D 0; lp_index--)
> +		mshv_lp_stats_unmap(lp_index);
> +	debugfs_remove_recursive(lp_dir);
> +free_lp_stats:
> +	kfree(mshv_lps_stats);

Set mshv_lps_stats to NULL?

> +
> +	return err;
> +}
> +
> +static int vp_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page **pstats =3D m->private;
> +	struct hv_counter_entry *entry =3D hv_vp_counters;
> +	int i;
> +
> +	/*
> +	 * For VP and partition stats, there may be two stats areas mapped,
> +	 * SELF and PARENT. These refer to the privilege level of the data in
> +	 * each page. Some fields may be 0 in SELF and nonzero in PARENT, or
> +	 * vice versa.
> +	 *
> +	 * Hence, prioritize printing from the PARENT page (more privileged
> +	 * data), but use the value from the SELF page if the PARENT value is
> +	 * 0.
> +	 */
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hv_vp_counters); i++, entry++) {
> +		u64 parent_val =3D pstats[HV_STATS_AREA_PARENT]->data[entry->idx];
> +		u64 self_val =3D pstats[HV_STATS_AREA_SELF]->data[entry->idx];
> +
> +		seq_printf(m, "%-43s: %llu\n", entry->name,
> +			   parent_val ? parent_val : self_val);
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(vp_stats);
> +
> +static void vp_debugfs_remove(struct dentry *vp_stats)
> +{
> +	debugfs_remove_recursive(vp_stats->d_parent);
> +}
> +
> +static int vp_debugfs_create(u64 partition_id, u32 vp_index,
> +			     struct hv_stats_page **pstats,
> +			     struct dentry **vp_stats_ptr,
> +			     struct dentry *parent)
> +{
> +	struct dentry *vp_idx_dir, *d;
> +	char vp_idx_str[U32_BUF_SZ];
> +	int err;
> +
> +	sprintf(vp_idx_str, "%u", vp_index);
> +
> +	vp_idx_dir =3D debugfs_create_dir(vp_idx_str, parent);
> +	if (IS_ERR(vp_idx_dir))
> +		return PTR_ERR(vp_idx_dir);
> +
> +	d =3D debugfs_create_file("stats", 0400, vp_idx_dir,
> +				     pstats, &vp_stats_fops);
> +	if (IS_ERR(d)) {
> +		err =3D PTR_ERR(d);
> +		goto remove_debugfs_vp_idx;
> +	}
> +
> +	*vp_stats_ptr =3D d;
> +
> +	return 0;
> +
> +remove_debugfs_vp_idx:
> +	debugfs_remove_recursive(vp_idx_dir);
> +	return err;
> +}
> +
> +static int partition_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page **pstats =3D m->private;
> +	struct hv_counter_entry *entry =3D hv_partition_counters;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hv_partition_counters); i++, entry++) {
> +		u64 parent_val =3D pstats[HV_STATS_AREA_PARENT]->data[entry->idx];
> +		u64 self_val =3D pstats[HV_STATS_AREA_SELF]->data[entry->idx];
> +
> +		seq_printf(m, "%-32s: %llu\n", entry->name,
> +			   parent_val ? parent_val : self_val);
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(partition_stats);
> +
> +static void mshv_partition_stats_unmap(u64 partition_id,
> +				       struct hv_stats_page *stats_page,
> +				       enum hv_stats_area_type stats_area_type)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.partition.partition_id =3D partition_id,
> +		.partition.stats_area_type =3D stats_area_type,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_PARTITION, stats_page,
> +				  &identity);
> +	if (err)
> +		pr_err("%s: failed to unmap partition %lld %s stats, err: %d\n",
> +		       __func__, partition_id,
> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "parent"=
,
> +		       err);
> +}
> +
> +static struct hv_stats_page *mshv_partition_stats_map(u64 partition_id,
> +						      enum hv_stats_area_type
> stats_area_type)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.partition.partition_id =3D partition_id,
> +		.partition.stats_area_type =3D stats_area_type,
> +	};
> +	struct hv_stats_page *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_PARTITION, &identity, &stats)=
;
> +	if (err) {
> +		pr_err("%s: failed to map partition %lld %s stats, err: %d\n",
> +		       __func__, partition_id,
> +		       (stats_area_type =3D=3D HV_STATS_AREA_SELF) ? "self" : "parent"=
,
> +		       err);
> +		return ERR_PTR(err);
> +	}
> +	return stats;
> +}
> +
> +static int mshv_debugfs_partition_stats_create(u64 partition_id,
> +					    struct dentry **partition_stats_ptr,
> +					    struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +	struct hv_stats_page **pstats;
> +	int err;
> +
> +	pstats =3D kcalloc(NUM_STATS_AREAS, sizeof(struct hv_stats_page *),
> +			 GFP_KERNEL_ACCOUNT);
> +	if (!pstats)
> +		return -ENOMEM;
> +
> +	pstats[HV_STATS_AREA_SELF] =3D mshv_partition_stats_map(partition_id,
> +							      HV_STATS_AREA_SELF);
> +	if (IS_ERR(pstats[HV_STATS_AREA_SELF])) {
> +		err =3D PTR_ERR(pstats[HV_STATS_AREA_SELF]);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * L1VH partition cannot access its partition stats in parent area.
> +	 */
> +	if (is_l1vh_parent(partition_id)) {
> +		pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> +	} else {
> +		pstats[HV_STATS_AREA_PARENT] =3D mshv_partition_stats_map(partition_id=
,
> +
> 	HV_STATS_AREA_PARENT);
> +		if (IS_ERR(pstats[HV_STATS_AREA_PARENT])) {
> +			err =3D PTR_ERR(pstats[HV_STATS_AREA_PARENT]);
> +			goto unmap_self;
> +		}
> +		if (!pstats[HV_STATS_AREA_PARENT])
> +			pstats[HV_STATS_AREA_PARENT] =3D pstats[HV_STATS_AREA_SELF];
> +	}
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     pstats, &partition_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		err =3D PTR_ERR(dentry);
> +		goto unmap_partition_stats;
> +	}
> +
> +	*partition_stats_ptr =3D dentry;
> +	return 0;
> +
> +unmap_partition_stats:
> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF])
> +		mshv_partition_stats_unmap(partition_id, pstats[HV_STATS_AREA_PARENT],
> +					   HV_STATS_AREA_PARENT);
> +unmap_self:
> +	mshv_partition_stats_unmap(partition_id, pstats[HV_STATS_AREA_SELF],
> +				   HV_STATS_AREA_SELF);
> +cleanup:
> +	kfree(pstats);
> +	return err;
> +}
> +
> +static void partition_debugfs_remove(u64 partition_id, struct dentry *de=
ntry)
> +{
> +	struct hv_stats_page **pstats =3D NULL;
> +
> +	pstats =3D dentry->d_inode->i_private;
> +
> +	debugfs_remove_recursive(dentry->d_parent);
> +
> +	if (pstats[HV_STATS_AREA_PARENT] !=3D pstats[HV_STATS_AREA_SELF]) {
> +		mshv_partition_stats_unmap(partition_id,
> +					   pstats[HV_STATS_AREA_PARENT],
> +					   HV_STATS_AREA_PARENT);
> +	}
> +
> +	mshv_partition_stats_unmap(partition_id,
> +				   pstats[HV_STATS_AREA_SELF],
> +				   HV_STATS_AREA_SELF);
> +
> +	kfree(pstats);
> +}
> +
> +static int partition_debugfs_create(u64 partition_id,
> +				    struct dentry **vp_dir_ptr,
> +				    struct dentry **partition_stats_ptr,
> +				    struct dentry *parent)
> +{
> +	char part_id_str[U64_BUF_SZ];
> +	struct dentry *part_id_dir, *vp_dir;
> +	int err;
> +
> +	if (is_l1vh_parent(partition_id))
> +		sprintf(part_id_str, "self");
> +	else
> +		sprintf(part_id_str, "%llu", partition_id);
> +
> +	part_id_dir =3D debugfs_create_dir(part_id_str, parent);
> +	if (IS_ERR(part_id_dir))
> +		return PTR_ERR(part_id_dir);
> +
> +	vp_dir =3D debugfs_create_dir("vp", part_id_dir);
> +	if (IS_ERR(vp_dir)) {
> +		err =3D PTR_ERR(vp_dir);
> +		goto remove_debugfs_partition_id;
> +	}
> +
> +	err =3D mshv_debugfs_partition_stats_create(partition_id,
> +						  partition_stats_ptr,
> +						  part_id_dir);
> +	if (err)
> +		goto remove_debugfs_partition_id;
> +
> +	*vp_dir_ptr =3D vp_dir;
> +
> +	return 0;
> +
> +remove_debugfs_partition_id:
> +	debugfs_remove_recursive(part_id_dir);
> +	return err;
> +}
> +
> +static void parent_vp_debugfs_remove(u32 vp_index,
> +				     struct dentry *vp_stats_ptr)
> +{
> +	struct hv_stats_page **pstats;
> +
> +	pstats =3D vp_stats_ptr->d_inode->i_private;
> +	vp_debugfs_remove(vp_stats_ptr);
> +	mshv_vp_stats_unmap(hv_current_partition_id, vp_index, pstats);
> +	kfree(pstats);
> +}
> +
> +static void mshv_debugfs_parent_partition_remove(void)
> +{
> +	int idx;
> +
> +	for_each_online_cpu(idx)
> +		parent_vp_debugfs_remove(idx,

The first parameter here ("idx") should be translated through the
hv_vp_index[] array like is done in mshv_debugfs_parent_partition_create().

> +					 parent_vp_stats[idx]);
> +
> +	partition_debugfs_remove(hv_current_partition_id,
> +				 parent_partition_stats);
> +	kfree(parent_vp_stats);
> +	parent_vp_stats =3D NULL;
> +	parent_partition_stats =3D NULL;
> +

Extra blank line.

> +}
> +
> +static int __init parent_vp_debugfs_create(u32 vp_index,
> +					   struct dentry **vp_stats_ptr,
> +					   struct dentry *parent)
> +{
> +	struct hv_stats_page **pstats;
> +	int err;
> +
> +	pstats =3D kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUN=
T);

Another case of using "2" that should be changed.

> +	if (!pstats)
> +		return -ENOMEM;
> +
> +	err =3D mshv_vp_stats_map(hv_current_partition_id, vp_index, pstats);
> +	if (err)
> +		goto cleanup;
> +
> +	err =3D vp_debugfs_create(hv_current_partition_id, vp_index, pstats,
> +				vp_stats_ptr, parent);
> +	if (err)
> +		goto unmap_vp_stats;
> +
> +	return 0;
> +
> +unmap_vp_stats:
> +	mshv_vp_stats_unmap(hv_current_partition_id, vp_index, pstats);
> +cleanup:
> +	kfree(pstats);
> +	return err;
> +}
> +
> +static int __init mshv_debugfs_parent_partition_create(void)
> +{
> +	struct dentry *vp_dir;
> +	int err, idx, i;
> +
> +	mshv_debugfs_partition =3D debugfs_create_dir("partition",
> +						     mshv_debugfs);
> +	if (IS_ERR(mshv_debugfs_partition))
> +		return PTR_ERR(mshv_debugfs_partition);
> +
> +	err =3D partition_debugfs_create(hv_current_partition_id,
> +				       &vp_dir,
> +				       &parent_partition_stats,
> +				       mshv_debugfs_partition);
> +	if (err)
> +		goto remove_debugfs_partition;
> +
> +	parent_vp_stats =3D kcalloc(num_possible_cpus(),

num_possible_cpus() should not be used to allocate an array that is
then indexed by the Linux CPU number. Use nr_cpu_ids instead when
allocating the array. See commit 16b18fdf6bc7 for the full explanation.
As explained in that commit message, using num_possible_cpus()
doesn't break things now, but it might in the future.

> +				  sizeof(*parent_vp_stats),
> +				  GFP_KERNEL);
> +	if (!parent_vp_stats) {
> +		err =3D -ENOMEM;
> +		goto remove_debugfs_partition;
> +	}
> +
> +	for_each_online_cpu(idx) {
> +		err =3D parent_vp_debugfs_create(hv_vp_index[idx],
> +					       &parent_vp_stats[idx],
> +					       vp_dir);
> +		if (err)
> +			goto remove_debugfs_partition_vp;
> +	}
> +
> +	return 0;
> +
> +remove_debugfs_partition_vp:
> +	for_each_online_cpu(i) {
> +		if (i >=3D idx)
> +			break;
> +		parent_vp_debugfs_remove(i, parent_vp_stats[i]);
> +	}
> +	partition_debugfs_remove(hv_current_partition_id,
> +				 parent_partition_stats);
> +
> +	kfree(parent_vp_stats);
> +	parent_vp_stats =3D NULL;
> +	parent_partition_stats =3D NULL;
> +
> +remove_debugfs_partition:
> +	debugfs_remove_recursive(mshv_debugfs_partition);
> +	mshv_debugfs_partition =3D NULL;
> +	return err;
> +}
> +
> +static int hv_stats_show(struct seq_file *m, void *v)
> +{
> +	const struct hv_stats_page *stats =3D m->private;
> +	struct hv_counter_entry *entry =3D hv_hypervisor_counters;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hv_hypervisor_counters); i++, entry++)
> +		seq_printf(m, "%-25s: %llu\n", entry->name,
> +			   stats->data[entry->idx]);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(hv_stats);
> +
> +static void mshv_hv_stats_unmap(void)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.hv.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	int err;
> +
> +	err =3D hv_unmap_stats_page(HV_STATS_OBJECT_HYPERVISOR, NULL, &identity=
);
> +	if (err)
> +		pr_err("%s: failed to unmap hypervisor stats: %d\n",
> +		       __func__, err);
> +}
> +
> +static void * __init mshv_hv_stats_map(void)
> +{
> +	union hv_stats_object_identity identity =3D {
> +		.hv.stats_area_type =3D HV_STATS_AREA_SELF,
> +	};
> +	struct hv_stats_page *stats;
> +	int err;
> +
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_HYPERVISOR, &identity, &stats=
);
> +	if (err) {
> +		pr_err("%s: failed to map hypervisor stats: %d\n",
> +		       __func__, err);
> +		return ERR_PTR(err);
> +	}
> +	return stats;
> +}
> +
> +static int __init mshv_debugfs_hv_stats_create(struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +	u64 *stats;
> +	int err;
> +
> +	stats =3D mshv_hv_stats_map();
> +	if (IS_ERR(stats))
> +		return PTR_ERR(stats);
> +
> +	dentry =3D debugfs_create_file("stats", 0400, parent,
> +				     stats, &hv_stats_fops);
> +	if (IS_ERR(dentry)) {
> +		err =3D PTR_ERR(dentry);
> +		pr_err("%s: failed to create hypervisor stats dentry: %d\n",
> +		       __func__, err);
> +		goto unmap_hv_stats;
> +	}
> +
> +	mshv_lps_count =3D num_present_cpus();

This method of setting mshv_lps_count, and the iteration through the lp_ind=
ex
in mshv_debugfs_lp_create() and mshv_debugfs_lp_remove(), seems risky. The
lp_index gets passed to the hypervisor, so it must be the hypervisor's conc=
ept
of the lp_index. Is that always guaranteed to be the same as Linux's number=
ing
of the present CPUs? There may be edge cases where it is not. For example, =
what
if Linux in the root partition were booted with the "nosmt" kernel boot opt=
ion,
such that Linux ignores all the 2nd hyper-threads in a core? Could that cre=
ate
a numbering mismatch?

Note that for vp_index, we have the hv_vp_index[] array for translating fro=
m
Linux's concept of a CPU number to Hyper-V's concept of vp_index. For
example, mshv_debugfs_parent_partition_create() correctly goes through
this translation. And presumably when the VMM code does the
MSHV_CREATE_VP ioctl, it is passing in a hypervisor vp_index.

Everything may work fine "as is" for the moment, but the lp functions here
are still conflating the hypervisor's LP numbering with Linux's CPU numberi=
ng,
and that seems like a recipe for trouble somewhere down the road. I'm
not sure how the hypervisor interprets the "lp_index" part of the identity
argument passed to a hypercall, so I'm not sure what the fix is.

> +
> +	return 0;
> +
> +unmap_hv_stats:
> +	mshv_hv_stats_unmap();
> +	return err;
> +}
> +
> +int mshv_debugfs_vp_create(struct mshv_vp *vp)
> +{
> +	struct mshv_partition *p =3D vp->vp_partition;
> +
> +	if (!mshv_debugfs)
> +		return 0;
> +
> +	return vp_debugfs_create(p->pt_id, vp->vp_index,
> +				 vp->vp_stats_pages,
> +				 &vp->vp_stats_dentry,
> +				 p->pt_vp_dentry);
> +}
> +
> +void mshv_debugfs_vp_remove(struct mshv_vp *vp)
> +{
> +	if (!mshv_debugfs)
> +		return;
> +
> +	vp_debugfs_remove(vp->vp_stats_dentry);
> +}
> +
> +int mshv_debugfs_partition_create(struct mshv_partition *partition)
> +{
> +	int err;
> +
> +	if (!mshv_debugfs)
> +		return 0;
> +
> +	err =3D partition_debugfs_create(partition->pt_id,
> +				       &partition->pt_vp_dentry,
> +				       &partition->pt_stats_dentry,
> +				       mshv_debugfs_partition);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +void mshv_debugfs_partition_remove(struct mshv_partition *partition)
> +{
> +	if (!mshv_debugfs)
> +		return;
> +
> +	partition_debugfs_remove(partition->pt_id,
> +				 partition->pt_stats_dentry);
> +}
> +
> +int __init mshv_debugfs_init(void)
> +{
> +	int err;
> +
> +	mshv_debugfs =3D debugfs_create_dir("mshv", NULL);
> +	if (IS_ERR(mshv_debugfs)) {
> +		pr_err("%s: failed to create debugfs directory\n", __func__);
> +		return PTR_ERR(mshv_debugfs);
> +	}
> +
> +	if (hv_root_partition()) {
> +		err =3D mshv_debugfs_hv_stats_create(mshv_debugfs);
> +		if (err)
> +			goto remove_mshv_dir;
> +
> +		err =3D mshv_debugfs_lp_create(mshv_debugfs);
> +		if (err)
> +			goto unmap_hv_stats;
> +	}
> +
> +	err =3D mshv_debugfs_parent_partition_create();
> +	if (err)
> +		goto unmap_lp_stats;
> +
> +	return 0;
> +
> +unmap_lp_stats:
> +	if (hv_root_partition()) {
> +		mshv_debugfs_lp_remove();
> +		mshv_debugfs_lp =3D NULL;
> +	}
> +unmap_hv_stats:
> +	if (hv_root_partition())
> +		mshv_hv_stats_unmap();
> +remove_mshv_dir:
> +	debugfs_remove_recursive(mshv_debugfs);
> +	mshv_debugfs =3D NULL;
> +	return err;
> +}
> +
> +void mshv_debugfs_exit(void)
> +{
> +	mshv_debugfs_parent_partition_remove();
> +
> +	if (hv_root_partition()) {
> +		mshv_debugfs_lp_remove();
> +		mshv_debugfs_lp =3D NULL;
> +		mshv_hv_stats_unmap();
> +	}
> +
> +	debugfs_remove_recursive(mshv_debugfs);
> +	mshv_debugfs =3D NULL;
> +	mshv_debugfs_partition =3D NULL;
> +}
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e4912b0618fa..7332d9af8373 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -52,6 +52,9 @@ struct mshv_vp {
>  		unsigned int kicked_by_hv;
>  		wait_queue_head_t vp_suspend_queue;
>  	} run;
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	struct dentry *vp_stats_dentry;
> +#endif
>  };
>=20
>  #define vp_fmt(fmt) "p%lluvp%u: " fmt
> @@ -136,6 +139,10 @@ struct mshv_partition {
>  	u64 isolation_type;
>  	bool import_completed;
>  	bool pt_initialized;
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +	struct dentry *pt_stats_dentry;
> +	struct dentry *pt_vp_dentry;
> +#endif
>  };
>=20
>  #define pt_fmt(fmt) "p%llu: " fmt
> @@ -327,6 +334,33 @@ int hv_call_modify_spa_host_access(u64 partition_id,=
 struct
> page **pages,
>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e, u64 arg,
>  				      void *property_value, size_t property_value_sz);
>=20
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +int __init mshv_debugfs_init(void);
> +void mshv_debugfs_exit(void);
> +
> +int mshv_debugfs_partition_create(struct mshv_partition *partition);
> +void mshv_debugfs_partition_remove(struct mshv_partition *partition);
> +int mshv_debugfs_vp_create(struct mshv_vp *vp);
> +void mshv_debugfs_vp_remove(struct mshv_vp *vp);
> +#else
> +static inline int __init mshv_debugfs_init(void)
> +{
> +	return 0;
> +}
> +static inline void mshv_debugfs_exit(void) { }
> +
> +static inline int mshv_debugfs_partition_create(struct mshv_partition *p=
artition)
> +{
> +	return 0;
> +}
> +static inline void mshv_debugfs_partition_remove(struct mshv_partition *=
partition) { }
> +static inline int mshv_debugfs_vp_create(struct mshv_vp *vp)
> +{
> +	return 0;
> +}
> +static inline void mshv_debugfs_vp_remove(struct mshv_vp *vp) { }
> +#endif
> +
>  extern struct mshv_root mshv_root;
>  extern enum hv_scheduler_type hv_scheduler_type;
>  extern u8 * __percpu *hv_synic_eventring_tail;
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 12825666e21b..f4654fb8cd23 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1096,6 +1096,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partiti=
on *partition,
>=20
>  	memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
>=20
> +	ret =3D mshv_debugfs_vp_create(vp);
> +	if (ret)
> +		goto put_partition;
> +
>  	/*
>  	 * Keep anon_inode_getfd last: it installs fd in the file struct and
>  	 * thus makes the state accessible in user space.
> @@ -1103,7 +1107,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>  	ret =3D anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
>  			       O_RDWR | O_CLOEXEC);
>  	if (ret < 0)
> -		goto put_partition;
> +		goto remove_debugfs_vp;
>=20
>  	/* already exclusive with the partition mutex for all ioctls */
>  	partition->pt_vp_count++;
> @@ -1111,6 +1115,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>=20
>  	return ret;
>=20
> +remove_debugfs_vp:
> +	mshv_debugfs_vp_remove(vp);
>  put_partition:
>  	mshv_partition_put(partition);
>  free_vp:
> @@ -1553,10 +1559,16 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
>  	if (ret)
>  		goto withdraw_mem;
>=20
> +	ret =3D mshv_debugfs_partition_create(partition);
> +	if (ret)
> +		goto finalize_partition;
> +
>  	partition->pt_initialized =3D true;
>=20
>  	return 0;
>=20
> +finalize_partition:
> +	hv_call_finalize_partition(partition->pt_id);
>  withdraw_mem:
>  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
>=20
> @@ -1736,6 +1748,7 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>  			if (!vp)
>  				continue;
>=20
> +			mshv_debugfs_vp_remove(vp);
>  			mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
>  					    vp->vp_stats_pages);
>=20
> @@ -1769,6 +1782,8 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>  			partition->pt_vp_array[i] =3D NULL;
>  		}
>=20
> +		mshv_debugfs_partition_remove(partition);
> +
>  		/* Deallocates and unmaps everything including vcpus, GPA mappings etc=
 */
>  		hv_call_finalize_partition(partition->pt_id);
>=20
> @@ -2314,10 +2329,14 @@ static int __init mshv_parent_partition_init(void=
)
>=20
>  	mshv_init_vmm_caps(dev);
>=20
> -	ret =3D mshv_irqfd_wq_init();
> +	ret =3D mshv_debugfs_init();
>  	if (ret)
>  		goto exit_partition;
>=20
> +	ret =3D mshv_irqfd_wq_init();
> +	if (ret)
> +		goto exit_debugfs;
> +
>  	spin_lock_init(&mshv_root.pt_ht_lock);
>  	hash_init(mshv_root.pt_htable);
>=20
> @@ -2325,6 +2344,8 @@ static int __init mshv_parent_partition_init(void)
>=20
>  	return 0;
>=20
> +exit_debugfs:
> +	mshv_debugfs_exit();
>  exit_partition:
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> @@ -2341,6 +2362,7 @@ static void __exit mshv_parent_partition_exit(void)
>  {
>  	hv_setup_mshv_handler(NULL);
>  	mshv_port_table_fini();
> +	mshv_debugfs_exit();
>  	misc_deregister(&mshv_dev);
>  	mshv_irqfd_wq_cleanup();
>  	if (hv_root_partition())
> --
> 2.34.1


