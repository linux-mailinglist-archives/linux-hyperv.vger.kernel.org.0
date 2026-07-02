Return-Path: <linux-hyperv+bounces-11823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8UvdJniuRmoJbgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11823-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:31:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E888D6FC0FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:31:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=b95GXywt;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11823-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11823-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528A330E1908
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9F37A839;
	Thu,  2 Jul 2026 17:47:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012053.outbound.protection.outlook.com [52.103.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA0360EF2;
	Thu,  2 Jul 2026 17:47:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014469; cv=fail; b=W6UHaEG+F5glsB/4h1e4A8ouJv+HWXF1ckJiuvhRB2NMx5jo86h6i+Bi8SUaoA2Mdam5QHoaY5jTE2kE/Td7HVE+1PyYB54HLKWRqh0REFuYwjE3s8yJO2LuEzXvWzK5SdO6YW5I56E+AXU2us9NZ5rrVBdoy51ZfKqJUw4oqOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014469; c=relaxed/simple;
	bh=W0zhmir/f0gSo8u55dA0z7G9wgYb10XbCHfKd1L1B0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XXB+r0H27x3SGji/ObZ2y3xzf3sTpJZ1pYTgrpOUv8rOzFNT6MPCAiZb3tfa/wkKD48bOSOf0kyFobfpgsV9gV3ap+19/oBLGPc5adzMODR0MX/U0EFEnSNu0HXjZW5qQDXdkvXgXO9XcqNUN0bbsTzQhvmuyfw1dw4tC/WBPIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b95GXywt; arc=fail smtp.client-ip=52.103.20.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaxK4zXuiGCXZXF456keOKJXgW709FOg6P3jbzDmJXAoEM0vaxEAZnhN64nKumuMpGuJeIP4zR5n8FLKSKbpaX1IGuxLwzDI49e1ysNEWND7ojP9M04ogcMuDjYYPE3azbE+IBOA53CvuxwceFTiKzFkYpU0sE6s70ln16UJ/WwgpAQQAF4A6RfWuRVYGbldWNWRi3XjmPRUUS1iPNJR4yUNgQDKcKXJbe6r3zsc4XFgfruBap07izS0ikqUuLE7Rk+rxEXK6gkudrUK9kZu5WBR0EnXwuCy9fNjFuwt0YJJpDs0eLvzyUtomKJ8+mxm6tjDYUNjzgKl9xYhqJJzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWmMUitMLSZDRRLFU2IMOWfB8yb8tq9o5kiAKU/+UXc=;
 b=yOD/YrqEiEz/nNbQeXBvGd9DHcr+X0whRvpC8KqNqeGP3JPXGdPbFBRpjW6kKc67LSMDDkyM2QzQmqUa0uuo3uIjow1giLQc8GJ+yy429RQjGxmB1+x+V8rHkWndEAdHd6uqKmbLlkd/mCtWpCPsdwDtlxLPlaJ/4Aqqi1x1hjhxCvYN4vDo0JnD9I0yxhs5w61seDfvlBKaMrP8r6h1R9Z1gF82SW+d6eKEZnP41rf/LngRTsVzfnJcFJzN9nosDGpqlxVqbaQJ5Lgey8tWkaaI5fstbYfwcLNVadTbGDY1wciW2wr39YSPduZFDsisgmpDsd/eph8AWDb7UUuAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWmMUitMLSZDRRLFU2IMOWfB8yb8tq9o5kiAKU/+UXc=;
 b=b95GXywtL9sHqekRWnl7on4Jdi3+jwz7xFCYUrW/+CR3REAEJ1DtGX/Z3tq0r6il+kJXOqYI/9AT57BkkWg62ka1poRGMFFXcEWRJ/cIuOK3SmBFdDdb/172WuNObQ3RMwpa5+atmEUHylmE/wrPHHNeKk51aKP6adF77WuilH0FNmQ9qIY9Q+5EqWolqkQzOjD4GrTRYaqurR4D2aZ7F97w6lVFkYFH18NfLiOE0RX8nY5N2T+wy9k6i8SDa+MuwbeF0YmyWnIchGvHKBI5imfuL1AAU4RSw6Um9cu/y7iNReIpUqd1Mk0t7B7Wc+lVOVHqLhnUCgaMaxxIU0+hnw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10144.namprd02.prod.outlook.com (2603:10b6:408:18f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:47:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:47:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, Kiryl
 Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen
 Gross <jgross@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, John
 Stultz <jstultz@google.com>
CC: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>,
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v5 11/51] x86/tsc: Add dedicated hypervisor hooks for
 getting known TSC/CPU frequencies
Thread-Topic: [PATCH v5 11/51] x86/tsc: Add dedicated hypervisor hooks for
 getting known TSC/CPU frequencies
Thread-Index: AQHdCZBiL1rak39MDUu25HviYbt1I7Zagp+Q
Date: Thu, 2 Jul 2026 17:47:41 +0000
Message-ID:
 <SN6PR02MB4157085BD25754FFC9D2F4F5D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-12-seanjc@google.com>
In-Reply-To: <20260701193212.749551-12-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10144:EE_
x-ms-office365-filtering-correlation-id: 608bedcf-0f7f-4e6a-a182-08ded86203c3
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0ADgXhcmcD8O8NksmzWPYmQHlsojLAIeNVDHf3Hw8hrqAX1b7rewvdJkeLwglK1GqPSN+rhPZdyuNmalCV3p4r2isH8zBwRkZ/vUdAfUanUSF+uFm8IadQVbbnjn37buSKUrlNlyN8yOtMpzsTjhUiRaz3yRzTM9WOCE01L2M4nRD3JoOKUCQTqgsQNk5Byr/zbzhFjLryElOFQ/qaIj5RQarCkr0YoBTjWGOvBQfZMP03+BJF91BLDXcfJn3dfATMLoztSSmDufasc5VMapOQPQzXlPmnBSpeB2FE0iNU4uJPETFWCmQKO6dvWOcmAW6zYTIkN4PUv7t6k4SRSE6yxI/G6tzRdrYB+FS6ZY62ZDXbF7Au7OWlI7KoL7+G6W9vULkG0i3Ji414oLjAD1vSuIeHV071vj3gMjVY8oQBJT3kMqMxduHSRkmh4fVe0/79QNc/56hR0vWaNEYGA1CC6ALvO85kWYWuyZQqQfgKX8fK1358qHPPkEMGhIWF2By4r77iOREeioHRmh0caUE3Su59L7BH/qwE0CSFggwlB7rJp2XznOlmGx7V9BMNXHVYAaY3OvfWXQnGEy+n1UWlES0O1s2W5ucQLvbrYcOnb9mf9xhnSk7/1a0eEvQkSlx00oTwGZsWHv3Y1xbnHF+/kto9cyq8Cm1i24Ja4TnCVVVBdd8vtYcDyEy1twvtzPIFbXdlvs7o4pu5bH+O2+Pl3Db2Dgl7puY4sGY/WXAJNy4vhUnKfLnIi3KdTisQ6+58
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|19101099003|2604032031799003|37011999003|13091999003|8060799015|8062599012|31061999003|41001999006|19110799012|25010399006|15080799012|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FjWRO8cQB0yTmG+KMmGFW0HenY9BSv4KQcfNr5+mYzBHqLcrBBlL7GNbiwZJ?=
 =?us-ascii?Q?24+az0axRiGnRTxFV5jVbWO3BYUpU4hWE/v6k1suyumA2SlZwd2o7VWUiWxa?=
 =?us-ascii?Q?V1ZTqjV9GZplqdZ5op/nmZBSVvKWtZNIh0pbAFiz4tRHaqx1b57/MHFY+RwV?=
 =?us-ascii?Q?WINkUqZxmdO9S1woT1tem0Vawl8fpKnzf7h1O8mVUbQ3K6qfVgIRdhZTc7lh?=
 =?us-ascii?Q?bz4kXPy5dvR6sPlBAKwZb/qengrtkWb73A0fmy+23k13nfdCh9GkbLJMU4Fw?=
 =?us-ascii?Q?eRpNp1vxM/EhdY2R5p5OTEQ0gKVD67iXuoTpNJDFp9pvsmwvx8dIWIIlEBlw?=
 =?us-ascii?Q?VFn6lPIWG/qmjzWUfgt6monNfOT0E6BTCRpZnlCmx+ZReCi1OQQNjJjFDRO9?=
 =?us-ascii?Q?DmVbGFWItMWY2Y9vcsE3XLRuK9GwCIB+Eu9LM3VG5J8Rqpc/aP/o95rCjfPs?=
 =?us-ascii?Q?n1gqxf571zRYL6A5Uq/TV3KlrF8Rp3WuBc3ELr7q1uk2M6SVva6mM0jNTs8r?=
 =?us-ascii?Q?iRwjo1c+RuS3H54WuKEDGMNMnL8ObgSuPru9djvA98F2kUduIYp5jl29i18H?=
 =?us-ascii?Q?qpjh5U1cJXAYMCd6SRA8EtABntKyQpinQY8AhP9RJeiC7nySNYrdb6pE1ZqR?=
 =?us-ascii?Q?EhxSahKr74ORyhPprUWJ0+92cRAON4Lsnx61P/VyYlqYCgp2s/9q3Yayd42H?=
 =?us-ascii?Q?Ero4Du+DBs2BWVOcCoNW6WYdE2ZKjs/ytvq2hWFgoW/oBNidl+n9uahh+/e6?=
 =?us-ascii?Q?aOGo47OYj9398v6zJg+cfJI9pQeZKUU8t2aOxxLbPMfPm6x9/Gmj5+8Fy8g1?=
 =?us-ascii?Q?16LLWxK8bUq3eC94HiljtZif7PNdNuZqRG0JiF1JRBMVuLITqEA5RPmSbWZx?=
 =?us-ascii?Q?/5rOZtiahJyPQupfk6jR//GWYgvUipsfE6t9qwi86tIvL4cKQwtGj0nrGibG?=
 =?us-ascii?Q?CWjx5w9MUy4Bdp+oXjSAD5yNIb6s2O+295G+m2IwN14UXtXp45Ac2MgIQ+va?=
 =?us-ascii?Q?vzGybE2SudLA2J7rQxi3SisZlOeKLVbAdlQLVOx/hUmbLsUSs8GwzxTlEQ8J?=
 =?us-ascii?Q?QvkxY3l7o80jKPH6Tudm6k8ibswskw0eHKMOq07dvGxVdZDl/G0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2+EkK3WJ2A8CFCVjmoXJpTqF27iqk2sV29foMuYdT+TAHJ7lGaUabB0nI4yS?=
 =?us-ascii?Q?/eTQrQyH09nlmVL394B8l23Gs4MPOgNaYVGE8HZ4GlW4QG0Zua0Wqy/VTejC?=
 =?us-ascii?Q?rqJS1jiiozTjCzRn4uZ2vYJuNsmMxSbwXn/H/1jzSCNNIvgy97oYdh5Hq1kr?=
 =?us-ascii?Q?xx4YWJHRbZuHXhi9uHKXR3NejhrkQhVmewGtnYK60DFQ3wZLRClNPR0yUafm?=
 =?us-ascii?Q?SPcVDF+H0YQO71ArmSoXzxH1GMIPxySEblcWyGrx9d+GvBSaw4RJ+LZjmeYr?=
 =?us-ascii?Q?4LafkM80RUhRl74SfaNxvbuEvFQcFfs0AgAN6EmEVSG6A4PmyZi7THG/tcLx?=
 =?us-ascii?Q?fHgs6jhkqSpUNGHk1kpA0TsGoRUmy9N4sD+NRL7rI1+p3q1mQGOOI0r0pgZl?=
 =?us-ascii?Q?i9Kvp5EU/nnYNOtg0VKbqrruftyo6qMg1P/wuwOEFlIHecco8B2GIgcaf1+g?=
 =?us-ascii?Q?TRmAY6+WA5N+uRCVhxVqjvCsgW+nnYC30vpodxBrvZFhgW7XacXgoDB3xCSa?=
 =?us-ascii?Q?BD718lFVSslHToBgxb2NM8jfz+69myHVYwcSh0Gk70nNLGIDoaI/cdl+rnHU?=
 =?us-ascii?Q?psGGGPKSEqw7aLlGCS34kGoYnW62Ru+RE37rFHaPeIdl+YmlGRBWbTvk+U4w?=
 =?us-ascii?Q?V+Lvuykm9Cky0/rwtjbPcASQr6vwZ+2LG5+jbY28/P0fOZBnGrutZE36Lp/8?=
 =?us-ascii?Q?pk7PdzMTwMnWxmCNToDeFAu4zHdA3vamiq9jpj0+v+eqy0urJIq3RiZIlA1p?=
 =?us-ascii?Q?+ncEq55wjexMmgYqv27zVIaoXSEXqpAx7ti1PTRc/076F/Aa7VE9QnpTS3b+?=
 =?us-ascii?Q?NbQoogfN6Uol9fjIoZjoHYbDDs7KZHxndEj9/jJtDubf1I97oHWVsxc8FvBN?=
 =?us-ascii?Q?PVF/XAjzUcoIPfuSll/p+WSzxM4RIgsUGyvsuSKAr8BJsiHm7gMfVpYrquZ0?=
 =?us-ascii?Q?DRgcjJClaYqtpHudZ+UDGfnUpa28hryUOiC3HIqPF9XeckB3rkg0E5lYwxIb?=
 =?us-ascii?Q?+UkJD0O0CykkcGVrrRIpi0p7uItZ7vP8CjG7HA5CSXuPPdPoNPAIu5nekx3F?=
 =?us-ascii?Q?2lFVkIGmXlPdbR9b7mviKrqmbEbHbXwJg1w3SC8KRKKdFfeQi3IACQlUs0sB?=
 =?us-ascii?Q?ZiyrJSA5z1wEDwwM+SKcnBjQxX3uDlif8CWezgpOCvPH+QD6C8n+y4+8GthW?=
 =?us-ascii?Q?nGaJuYmIyUYJh5tSL4vEosOdzPepUgmtZxZF3eTdnqv5IPIkJdt6IO41NbEF?=
 =?us-ascii?Q?+or5paPKFKqlKfjr8QGlV6C/sFrEprjxbX617KEJn0vfSK1piRdtwlsizP47?=
 =?us-ascii?Q?V5lAJ04lNQGk1UZOu2qFTo5Y7GSl1GzghIelRAffNdkTv0iol838Od8SkD8s?=
 =?us-ascii?Q?Ms9G1uA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 608bedcf-0f7f-4e6a-a182-08ded86203c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 17:47:41.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11823-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E888D6FC0FF

From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, July 1, 2026=
 12:32 PM
>=20
> Add dedicated hypervisor hooks for getting known TSC/CPU frequencies
> instead of overriding seemingly generic platform hooks, and explicitly
> priotize hypervisor-provided frequencies over native methods, but do NOT

s/priotize/prioritize/

> clobber the frequency obtained from trusted firmware.  While shuffling th=
e
> hooks around is arguably "six of one, half dozen of the other", scoping
> them to x86_hyper_init makes their purpose more obvious, and allows for
> explicitly defining the priority of sources (as is done here).
>=20
> As is already done when trusted firmware provides the TSC frequency, igno=
re

Word "ignore" is duplicated.

> ignore tsc_early_khz if the exact TSC frequency was obtained from the
> hypervisor, as attempting to refine the TSC frequency when running in a V=
M
> is all but guaranteed to cause problems sooner or later due to the
> calibration sources being emulated devices in the vast majority of setups=
.
>=20
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For the Hyper-V changes,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>=20

> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +-
>  arch/x86/include/asm/acrn.h                   |  5 ----
>  arch/x86/include/asm/x86_init.h               |  4 +++
>  arch/x86/kernel/cpu/acrn.c                    | 10 +++++--
>  arch/x86/kernel/cpu/mshyperv.c                |  6 ++--
>  arch/x86/kernel/cpu/vmware.c                  |  8 ++---
>  arch/x86/kernel/jailhouse.c                   |  6 ++--
>  arch/x86/kernel/kvmclock.c                    |  6 ++--
>  arch/x86/kernel/tsc.c                         | 29 ++++++++++++++-----
>  arch/x86/xen/time.c                           |  4 +--
>  10 files changed, 50 insertions(+), 31 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-
> guide/kernel-parameters.txt
> index 490e6aa72fc2..a387bb2c47e2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7948,7 +7948,8 @@ Kernel parameters
>=20
>  			Note, tsc_early_khz is ignored if the TSC frequency is
>  			provided by trusted firmware when running as an SNP or
> -			TDX guest.
> +			TDX guest, or when the hypervisor provides the exact
> +			frequency via a paravirtual interface.
>=20
>  	tsx=3D		[X86] Control Transactional Synchronization
>  			Extensions (TSX) feature in Intel processors that
> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
> index db42b477c41d..a892179c61c6 100644
> --- a/arch/x86/include/asm/acrn.h
> +++ b/arch/x86/include/asm/acrn.h
> @@ -32,11 +32,6 @@ static inline u32 acrn_cpuid_base(void)
>  	return 0;
>  }
>=20
> -static inline unsigned long acrn_get_tsc_khz(void)
> -{
> -	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> -}
> -
>  /*
>   * Hypercalls for ACRN
>   *
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_i=
nit.h
> index 953d3199408a..0c89bf40f507 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -123,6 +123,8 @@ struct x86_init_pci {
>   * @msi_ext_dest_id:		MSI supports 15-bit APIC IDs
>   * @init_mem_mapping:		setup early mappings during init_mem_mapping()
>   * @init_after_bootmem:		guest init after boot allocator is finished
> + * @get_tsc_khz:		get the TSC frequency (returns 0 if frequency is unkno=
wn)
> + * @get_cpu_khz:		get the CPU frequency (returns 0 if frequency is unkno=
wn)
>   */
>  struct x86_hyper_init {
>  	void (*init_platform)(void);
> @@ -131,6 +133,8 @@ struct x86_hyper_init {
>  	bool (*msi_ext_dest_id)(void);
>  	void (*init_mem_mapping)(void);
>  	void (*init_after_bootmem)(void);
> +	unsigned int (*get_tsc_khz)(void);
> +	unsigned int (*get_cpu_khz)(void);
>  };
>=20
>  /**
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index dc119af83524..ad8f2da8003b 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -24,13 +24,15 @@ static u32 __init acrn_detect(void)
>  	return acrn_cpuid_base();
>  }
>=20
> +static unsigned int __init acrn_get_tsc_khz(void)
> +{
> +	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> +}
> +
>  static void __init acrn_init_platform(void)
>  {
>  	/* Install system interrupt handler for ACRN hypervisor callback */
>  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> -
> -	x86_platform.calibrate_tsc =3D acrn_get_tsc_khz;
> -	x86_platform.calibrate_cpu =3D acrn_get_tsc_khz;
>  }
>=20
>  static bool acrn_x2apic_available(void)
> @@ -78,4 +80,6 @@ const __initconst struct hypervisor_x86 x86_hyper_acrn =
=3D {
>  	.type			=3D X86_HYPER_ACRN,
>  	.init.init_platform     =3D acrn_init_platform,
>  	.init.x2apic_available  =3D acrn_x2apic_available,
> +	.init.get_tsc_khz	=3D acrn_get_tsc_khz,
> +	.init.get_cpu_khz	=3D acrn_get_tsc_khz,
>  };
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 87beecec76f0..f9bc1c2d8c93 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -395,7 +395,7 @@ static int hv_nmi_unknown(unsigned int val, struct pt=
_regs *regs)
>  }
>  #endif
>=20
> -static unsigned long hv_get_tsc_khz(void)
> +static unsigned int __init hv_get_tsc_khz(void)
>  {
>  	unsigned long freq;
>=20
> @@ -573,8 +573,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
> -		x86_platform.calibrate_tsc =3D hv_get_tsc_khz;
> -		x86_platform.calibrate_cpu =3D hv_get_tsc_khz;
> +		x86_init.hyper.get_tsc_khz =3D hv_get_tsc_khz;
> +		x86_init.hyper.get_cpu_khz =3D hv_get_tsc_khz;
>  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	}
>=20
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 13b97265c535..3cb473cae462 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -64,7 +64,7 @@ struct vmware_steal_time {
>  	u64 reserved[7];
>  };
>=20
> -static unsigned long vmware_tsc_khz __ro_after_init;
> +static unsigned long vmware_tsc_khz __initdata;
>  static u8 vmware_hypercall_mode     __ro_after_init;
>=20
>  unsigned long vmware_hypercall_slow(unsigned long cmd,
> @@ -137,7 +137,7 @@ static inline int __vmware_platform(void)
>  	return eax !=3D UINT_MAX && ebx =3D=3D VMWARE_HYPERVISOR_MAGIC;
>  }
>=20
> -static unsigned long vmware_get_tsc_khz(void)
> +static unsigned int __init vmware_get_tsc_khz(void)
>  {
>  	return vmware_tsc_khz;
>  }
> @@ -419,8 +419,8 @@ static void __init vmware_platform_setup(void)
>  		}
>=20
>  		vmware_tsc_khz =3D tsc_khz;
> -		x86_platform.calibrate_tsc =3D vmware_get_tsc_khz;
> -		x86_platform.calibrate_cpu =3D vmware_get_tsc_khz;
> +		x86_init.hyper.get_tsc_khz =3D vmware_get_tsc_khz;
> +		x86_init.hyper.get_cpu_khz =3D vmware_get_tsc_khz;
>=20
>  		/* Skip lapic calibration since we know the bus frequency. */
>  		apic_set_timer_period_hz(ecx, "VMware hypervisor");
> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
> index f2d4ef89c085..e24c05ab4fae 100644
> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -68,7 +68,7 @@ static void __init jailhouse_timer_init(void)
>  	apic_set_timer_period_khz(setup_data.v1.apic_khz, "Jailhouse hypervisor=
");
>  }
>=20
> -static unsigned long jailhouse_get_tsc(void)
> +static unsigned int __init jailhouse_get_tsc(void)
>  {
>  	return precalibrated_tsc_khz;
>  }
> @@ -210,8 +210,6 @@ static void __init jailhouse_init_platform(void)
>  	x86_init.mpparse.parse_smp_cfg		=3D jailhouse_parse_smp_config;
>  	x86_init.pci.arch_init			=3D jailhouse_pci_arch_init;
>=20
> -	x86_platform.calibrate_cpu		=3D jailhouse_get_tsc;
> -	x86_platform.calibrate_tsc		=3D jailhouse_get_tsc;
>  	x86_platform.get_wallclock		=3D jailhouse_get_wallclock;
>  	x86_platform.legacy.rtc			=3D 0;
>  	x86_platform.legacy.warm_reset		=3D 0;
> @@ -293,5 +291,7 @@ const struct hypervisor_x86 x86_hyper_jailhouse __ref=
const =3D {
>  	.detect			=3D jailhouse_detect,
>  	.init.init_platform	=3D jailhouse_init_platform,
>  	.init.x2apic_available	=3D jailhouse_x2apic_available,
> +	.init.get_tsc_khz	=3D jailhouse_get_tsc,
> +	.init.get_cpu_khz	=3D jailhouse_get_tsc,
>  	.ignore_nopv		=3D true,
>  };
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index cb3d0ca1fa22..4f8299303a19 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -136,7 +136,7 @@ static inline void kvm_sched_clock_init(bool stable)
>   * poll of guests can be running and trouble each other. So we preset
>   * lpj here
>   */
> -static unsigned long kvm_get_tsc_khz(void)
> +static unsigned int __init kvm_get_tsc_khz(void)
>  {
>  	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	return pvclock_tsc_khz(this_cpu_pvti());
> @@ -343,8 +343,8 @@ void __init kvmclock_init(void)
>  	flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
>  	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
>=20
> -	x86_platform.calibrate_tsc =3D kvm_get_tsc_khz;
> -	x86_platform.calibrate_cpu =3D kvm_get_tsc_khz;
> +	x86_init.hyper.get_tsc_khz =3D kvm_get_tsc_khz;
> +	x86_init.hyper.get_cpu_khz =3D kvm_get_tsc_khz;
>  	x86_platform.get_wallclock =3D kvm_get_wallclock;
>  	x86_platform.set_wallclock =3D kvm_set_wallclock;
>  #ifdef CONFIG_X86_LOCAL_APIC
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 86384a83a5f6..1dca9464b41c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1451,13 +1451,17 @@ static int __init init_tsc_clocksource(void)
>  device_initcall(init_tsc_clocksource);
>=20
>  static bool __init determine_cpu_tsc_frequencies(bool early,
> +						 unsigned int known_cpu_khz,
>  						 unsigned int known_tsc_khz)
>  {
>  	/* Make sure that cpu and tsc are not already calibrated */
>  	WARN_ON(cpu_khz || tsc_khz);
>=20
>  	if (early) {
> -		cpu_khz =3D x86_platform.calibrate_cpu();
> +		if (known_cpu_khz)
> +			cpu_khz =3D known_cpu_khz;
> +		else
> +			cpu_khz =3D x86_platform.calibrate_cpu();
>  		if (known_tsc_khz)
>  			tsc_khz =3D known_tsc_khz;
>  		else
> @@ -1514,7 +1518,7 @@ static void __init tsc_enable_sched_clock(void)
>=20
>  void __init tsc_early_init(void)
>  {
> -	unsigned int known_tsc_khz =3D 0;
> +	unsigned int known_cpu_khz =3D 0, known_tsc_khz =3D 0;
>=20
>  	if (!boot_cpu_has(X86_FEATURE_TSC))
>  		return;
> @@ -1522,22 +1526,33 @@ void __init tsc_early_init(void)
>  	if (is_early_uv_system())
>  		return;
>=20
> +	if (x86_init.hyper.get_cpu_khz)
> +		known_cpu_khz =3D x86_init.hyper.get_cpu_khz();
> +
>  	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
>  		known_tsc_khz =3D snp_secure_tsc_init();
>  	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
>  		known_tsc_khz =3D tdx_tsc_init();
>=20
> +	/*
> +	 * If the TSC frequency wasn't provided by trusted firmware, try to get
> +	 * it from the hypervisor (which is untrusted when running as a CoCo gu=
est).
> +	 */
> +	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
> +		known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> +
>  	/*
>  	 * Ignore the user-provided TSC frequency if the exact frequency was
> -	 * obtained from trusted firmware, as the user-provided frequency is
> -	 * intended as a "starting point", not a known, guaranteed frequency.
> +	 * obtained from trusted firmware or the hypervisor, as the user-
> +	 * provided frequency is intended as a "starting point", not a known,
> +	 * guaranteed frequency.
>  	 */
>  	if (!known_tsc_khz)
>  		known_tsc_khz =3D tsc_early_khz;
>  	else if (tsc_early_khz)
> -		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware.\n");
> +		pr_err("Ignoring 'tsc_early_khz' in favor of firmware/hypervisor.\n");
>=20
> -	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
> +	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz))
>  		return;
>  	tsc_enable_sched_clock();
>  }
> @@ -1558,7 +1573,7 @@ void __init tsc_init(void)
>=20
>  	if (!tsc_khz) {
>  		/* We failed to determine frequencies earlier, try again */
> -		if (!determine_cpu_tsc_frequencies(false, 0)) {
> +		if (!determine_cpu_tsc_frequencies(false, 0, 0)) {
>  			mark_tsc_unstable("could not calculate TSC khz");
>  			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
>  			return;
> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index d62c14334b35..1adb44fdddb2 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -38,7 +38,7 @@
>  static u64 xen_sched_clock_offset __read_mostly;
>=20
>  /* Get the TSC speed from Xen */
> -static unsigned long xen_tsc_khz(void)
> +static unsigned int __init xen_tsc_khz(void)
>  {
>  	struct pvclock_vcpu_time_info *info =3D
>  		&HYPERVISOR_shared_info->vcpu_info[0].time;
> @@ -569,7 +569,7 @@ static void __init xen_init_time_common(void)
>  	static_call_update(pv_steal_clock, xen_steal_clock);
>  	paravirt_set_sched_clock(xen_sched_clock);
>=20
> -	x86_platform.calibrate_tsc =3D xen_tsc_khz;
> +	x86_init.hyper.get_tsc_khz =3D xen_tsc_khz;
>  	x86_platform.get_wallclock =3D xen_get_wallclock;
>  }
>=20
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>=20


