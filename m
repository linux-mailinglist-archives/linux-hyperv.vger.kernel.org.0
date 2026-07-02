Return-Path: <linux-hyperv+bounces-11824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5OzSGOqsRmq3bQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11824-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:24:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00CA6FBFF9
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=pLjHkLTj;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11824-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11824-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E853291C33
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3765381E99;
	Thu,  2 Jul 2026 17:48:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010002.outbound.protection.outlook.com [52.103.12.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8C35F179;
	Thu,  2 Jul 2026 17:47:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014482; cv=fail; b=tNIGlTm50tCUzsgXvqXaky7LltxxBFJxHgP1be1T1/cX9yAdBHL95/CdKjIQPD3RkIIHY6du4yrPUIe7QM4GkkJkXZCWQ7DKZgtgA7X8yGyBdpMacUeTXsLw5blly/1fa7qteyEN5sDpAzlF3MLG1A/3nBfx3NOIytfanwxcBNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014482; c=relaxed/simple;
	bh=OOoApvrfB9vLt4pbB2rwAqIbudAwmzSxl6lNTMwvqsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPVfZZP9AeAK87FEIhrmkWNXP/NSJqMjoPCVQ8jwzKAQObL59n5i4QXkOjq4Xy8hkRMhvUt3yBKr/KY7ylrx4EmgHHbwWWYR6TyjBZaHxTxjN3ss3U03sPLjA8Emd/JPlnckqSVXlTJxgFvUcZYG/Dyx9fyXq7nRTTweHVTAJ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pLjHkLTj; arc=fail smtp.client-ip=52.103.12.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHoEp7dCJNfZ2ZEYm/gm9MNVzODF6uNunrGbwyFYG6dJ7U7U06e4d1kCGT5Y9poMpqx7SM2ZdOCmAsVl7N+y0syGRgIW8N1W6dwapBFpOtVKk+EkyTl7p+flLIVd1krsOwDpPdWpea+0MTM7v50Z+NERPXcGY9o9OCOISv0uMPUwKC5k1UOowuHfjarZAstBwezEsJcplgK0DMFhNp5HrPYvV/ilk+fHosBeGErcGHNULVzW9Ek3xFbqr7BYHXBcVqAsY5KDq+yaRT6i6e00DTiasSaNK0q8SMgGR/DwclndAGDvo3WG87WW9h+JEpuCu0xBVlWUogQgPdw4xcRG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G/iF/UE8E5eJfmXsP11xDkhwiBaGeTGpy27NbqqiJA=;
 b=CuIcHBPd6cKQLaEvdL1PqAHyCFffbi70t+H3NVC8ZISZJff+ofDBD3kcTF/N9yZzyGg1Aa/md/eDQ0MjqDu8h2OWlLFDUcUmwyOqrqj8+5xDMMdDf9BrYZ4Ug3Nh4ChHODand2k9JRJ+HgPSLXgDQGYLHmvYcMHsdcTT0gmHNXHJepecZRZ5ABG3tIW5ReuyHuDxXY7ggNpUFwh2Bax05Ll8g0ggntUEsgf7/r+C2kPyhTc7JEx7eIai0oRAzSA2i65UAR0twi6lrXBynxrHVTb25X/pFFljfx/K2U4uMEz+Bk1cdJ3T6geyU0eTDJna5cOO8qGDsOH1n9JB+Ssc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G/iF/UE8E5eJfmXsP11xDkhwiBaGeTGpy27NbqqiJA=;
 b=pLjHkLTjRY7SL6oMuKrPzcF0TKzE/f7W/qu/2sAJUIRyjjWoGj9KJY6Yfe0UX/Hs7sJTFUxVyFC6SxQH52J0nxe9iGo12gpM3v+DkXCCNAKaILJsUn1QCLQCtfx7LF6DGaWcHEd+TBmN/Sls7lwj649F18zqDM7UvL/ytznNlNTP2LFvCUpAFCj/pAvU3rIzSL3UWVobMRq+rS3KMhNo1aFGw5pAdI72rl3zvouD9FA1FFriN/S/qPrhI4SWveYxAa9Ic+NmD5NGYhTcU71y+/9zIEMzq2iIpackyfreNZksU0F5Kyar0by8Nzf5ASGZHSCCTgOS/C63qLf5mPeVag==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10144.namprd02.prod.outlook.com (2603:10b6:408:18f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:47:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:47:54 +0000
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
Subject: RE: [PATCH v5 14/51] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
Thread-Topic: [PATCH v5 14/51] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
Thread-Index: AQHdCZBo3fC/rBiXmkyrOoc2yLGVY7Zagq9Q
Date: Thu, 2 Jul 2026 17:47:54 +0000
Message-ID:
 <SN6PR02MB4157A8B2BC4C41FA5596CA42D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-15-seanjc@google.com>
In-Reply-To: <20260701193212.749551-15-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10144:EE_
x-ms-office365-filtering-correlation-id: 7e735224-d18e-4d76-5415-08ded8620b95
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0ATSI6n101gleWPZ+LxoY8/5cb6C/shF5Ih0Hn092D14Pn4D/9I/HbBPvhjVldxo3XYuQ9DVtjNxkw82om94dSRT6eLqLcY7HzSrlv4MNnP+aj8F8x8/9970aQXiX+Bz6jmZ8/h5vfmjfOuVaJtyek7dY0ORq3MUtJ7+hiQFfSTuS9VyZyOVL/ljDRMe6gB10eJpocaD7syQuNkL7gWZSaUbF9fuawuW4o+hb4yKivswiKsTFaPrCtWH5k+20lx807gmul9NZLedoSHDAWR5G8htGjaRgPZagaNt5Ki3CcNBbKpqpPaVRo9o5zUYCd3cKylcIDAppOZ18kmwFm0/XFIdgldzBuTFjo/8k5DpHqW1rjxWYlpf9F8KnJlGZgIJEsuAFH2Y94vlufiZSbk7XANlEpVHQsPJR95AFFfEff0FxLwGTCQbGEoB08AareuAzyXl1ptVNZxnW9he84pMbEYlheNXKp1JeY/f5iMn8JF/1rs4R1aE+/n79npIrbf+wPgAcMYfLB+rIwhTZ1VXhe0x4V32zx3AezoU6fkoRJ8yGpG3Hb9JDUsf6T352K58Kol793lSmQuFAHgPGVGRox9NmzSOVRlFoBTfDNdydCks+QfviZjgWYZ082onf4HVadxEI5VXhmTW2moxSbKMXk7iiASqDEB4AGjmFVqk1ZSUUthoPISD4gF/bYRnbMft8nw4eC8ZDJJ2DgmR3iKi4ixqeuRvPhIkaogG2AYA3gq60l7/EgAREzACsEdfwA97cq
x-microsoft-antispam:
 BCL:0;ARA:14566002|16051099003|51005399006|19101099003|2604032031799003|37011999003|13091999003|8060799015|8062599012|31061999003|41001999006|19110799012|25010399006|15080799012|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xlTLF8VHk2mVYDxNPmyNyz9IsIDRGFuy97oGnlCy9hjUPDeUqFKlUlBFuhwc?=
 =?us-ascii?Q?13p4tTeObKDvQ2KB1BQJQx6wmxIVGjO8nnRBHR0A/hRKt2ZI8m5CsQDrOvr3?=
 =?us-ascii?Q?o9IbfzBrbUF66oKZ16298Fuay6gt1n+7C8yLrLDZxiW6xfXdIlXQyG4ozyhV?=
 =?us-ascii?Q?6FIJ6Obbm5BruShxr4PXNs444ZuLrFgPhPhw/jrzD90dlRVulvgEE+YPSStn?=
 =?us-ascii?Q?4E43RYJNNyZ8oBVcvMJMPN3JbfywWHQfPqMdoi/DAZLOk9+9LMzjPbyvIcYO?=
 =?us-ascii?Q?9nXXm4CPFG0A13LiSDzNjSncQCMTCxwUIEdvJJ1wvQMOAeJsRIcYh+uFgcjF?=
 =?us-ascii?Q?GZ35u8UTLmaV5P+EWDQdqCBjk7K9RjzlmPEuYhojW50TnqjOrECq+i4Zr3md?=
 =?us-ascii?Q?SortMf1w/VO/9ZLhdBQDlkui+NdqJWAKrGd1GQmEwQZKXkF+li7rAPK3i5+7?=
 =?us-ascii?Q?Mn986ANy7pyKYN5LaXFK7TOqZ1unYRQpQEy4d/BMls/unHQRBTJebJ5/ZScE?=
 =?us-ascii?Q?xbiXvwTOupDny3i6NudS1VRKqsQsjMRtYwyUClNpjVDa0uRyDppbqtEN0egG?=
 =?us-ascii?Q?JvxxugZfRZrYVgyuz0x8y/SLR91Y8tSWNnLuCjSv5nnoX/LmuDuh/maxZT+X?=
 =?us-ascii?Q?KDiSlwgosi3XG7Vq8pUaqKAz/OGXfaYjadBKnahMrw4Xg8k6gyeyjMprPulh?=
 =?us-ascii?Q?5ASMdy3cfg3Jl1aGx9ILdsnFOF5uFJsBANV2wqFVCoRp+5KZPZCT0dq4G5bH?=
 =?us-ascii?Q?5V8P6XWECYR4/gPujyLpY/6i6DFdkIwL8XY7+x11D141DEy6vFQtkWosCtDT?=
 =?us-ascii?Q?tza6B+SmdRkcrvFHe2NzAdPi8OQgUV4jHGAZi58JCSWPts1Pe3ccPvt3og+S?=
 =?us-ascii?Q?8EJUB0ajZYPNjyMvNi8F2wqzHU7vtkzXWbwAoqhJdvTUCQxTZXMOOQh2G2r+?=
 =?us-ascii?Q?sdoSAmesMg5mMvGbYiG5xFtIIQ0KdFJfHLFaeHxMEHC56vAjPpnCkPctAIJl?=
 =?us-ascii?Q?4b7zRRuupvgS2RHSuSdi7SA/cFaDSk/0NriOL23tIWhaW1+MUYKoWaLXeIve?=
 =?us-ascii?Q?gamOOBdRCQlxn229LYTLFmn0zBmJ2t59o5RfW0Ix0gGY8+Pw1SH3R6S6oH7V?=
 =?us-ascii?Q?bfzxeC1EcvLf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WtAwUa0GT7zoPNOR5eAD5D8n1jZ5qyjc5SXCkQxlLud9GLCVWQkU5NYMqVAo?=
 =?us-ascii?Q?gvGwoNPdGx+gg7rFn2IpSNt2nTWL7Lg58peYDqJBFCTRefBDLYh4jhVopHL1?=
 =?us-ascii?Q?m27aJWcCcUa29RXDT5FkCfurwYfFjzL8gj7auj9iB8egKfCIfNBTV0gnR7aq?=
 =?us-ascii?Q?kQReOmaHAcpRLchiEaoKkAA97kjWRnqOwtMQbvkiFXJ43G7q1oEi4fuWDKz1?=
 =?us-ascii?Q?GOuRxvBen0FNVCrwxMnCqt/T3UReyuuCIuq2CNn6DymfTlfPEWAQJ6Jg43UK?=
 =?us-ascii?Q?1KnPSXQcFgyptKH4Zn7z//UJO2vLNkn+an9tlvWyEiQmY0DZ2r9KYwPQstk5?=
 =?us-ascii?Q?+pHn1Iqd/fYwuRhU8RFkaGJ+x3QkQFglDcaRCMzfyOlqZMxToF49V2t8VvX7?=
 =?us-ascii?Q?ks54ClCv64sC4n87zVuS4qqvV67MWqiJ9fN5Lnq53X0SlF0KFXBsR1lZMAv9?=
 =?us-ascii?Q?HKiLMPFoqsjNPRpMvLUWQOLypsEpPKfDAOZEYGkS+60gFQSGEpY6wuT02Xw+?=
 =?us-ascii?Q?fIK6iYXBg99CykG4zNH1B4qhzJriI+NFfVUQKZ+d3cDhWip8lR8QW05/pyxW?=
 =?us-ascii?Q?6V/EgNodaIz1Gm72C9ER92shdtxjdZc+aKTiKe8O3nAS+VdAVfYLA+5PuugH?=
 =?us-ascii?Q?AARHMYMLYMXJOUZxO0WX5iNKPrm1vQIpingTijaEPFmFS9goz5gqcsscv6MT?=
 =?us-ascii?Q?hqQ4cQ15OWOPeBEzKCkWCj0l76ai81Bsq4uAve6PIm9Brm24ZGljtoUg5XHc?=
 =?us-ascii?Q?eb4+eUxl0tYM6rmtBXMTOixVdkEWXN+rVNKJGF5Z6uVD3cVLNAyrYY7UWwt6?=
 =?us-ascii?Q?TtRzAR83X6SOmnk6eBLh6QoVBevG4qonZPsMwqFdqZQS+xX0sn+lE8wT27Uh?=
 =?us-ascii?Q?pYtv3mWSN9aiSBxO5Fwn9+i0ocf4a/WQ3NMm6Z7o99bu/b83cP7AW741FmLE?=
 =?us-ascii?Q?WTJUzHSsdg21Z0Q6c42RC0LGp3Y5gZapWYbi+wzaemqFlMQ3tE1+FJ42s0HS?=
 =?us-ascii?Q?0Cf0O3PFpV1HuCxU4FzmRaCrsMLj0NCqPFYbRNP88odYn7jVxqjI+4pyvVMQ?=
 =?us-ascii?Q?4S97eFhW+ECEzYq4a+OPnObM+aOHvsySDy/Q9fcIj24W000Fz2AnNZsceSD4?=
 =?us-ascii?Q?dOKkDUICWAlb8ca2yLwQTiOY1QzzRjw52rhMPNfo7rM/c0G2pKOCH1sYjDoU?=
 =?us-ascii?Q?l+5zuNBy8FYuQd8nYqac6cS5JUajH0h2+PhETaA8BdulsFZtgc48bOGyw4cF?=
 =?us-ascii?Q?1RMDcj+agQzfXbuXLZQ9Nk3HF3uT19zqefEHaKdvBvmSBRdsRaSz03++/OWo?=
 =?us-ascii?Q?XGW+PK1LYM1YzmZuGp/6vcli5+omuRR+DcdGJyZc9FcWCRyx1X6Uywn3hIR1?=
 =?us-ascii?Q?SQN67sg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e735224-d18e-4d76-5415-08ded8620b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 17:47:54.5401
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
	TAGGED_FROM(0.00)[bounces-11824-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B00CA6FBFF9

From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, July 1, 2026=
 12:32 PM
>=20
> Now that all paravirt code that explicitly specifies the TSC frequency
> also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
> and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is known.
>=20
> Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was provided
> by the user.  Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_khz comman=
d
> line parameter"), one of the goals of the param is to allow the refined
> calibration work "to do meaningful error checking".
>=20
> No functional change intended.
>=20
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For the Hyper-V changes,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/x86/coco/sev/core.c       |  1 -
>  arch/x86/coco/tdx/tdx.c        |  1 -
>  arch/x86/kernel/cpu/acrn.c     |  1 -
>  arch/x86/kernel/cpu/mshyperv.c |  1 -
>  arch/x86/kernel/cpu/vmware.c   |  2 --
>  arch/x86/kernel/jailhouse.c    |  1 -
>  arch/x86/kernel/kvmclock.c     |  1 -
>  arch/x86/kernel/tsc.c          | 13 ++++++++++---
>  arch/x86/xen/time.c            |  1 -
>  9 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index bc5ae9ef74da..72313b36b6f5 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2027,7 +2027,6 @@ unsigned int __init snp_secure_tsc_init(void)
>=20
>  	secrets =3D (__force struct snp_secrets_page *)mem;
>=20
> -	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>=20
>  	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index ae2d35f2ef33..94682aca188b 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -1205,7 +1205,6 @@ unsigned int __init tdx_tsc_init(void)
>=20
>  	/* TSC is the only reliable clock in TDX guest */
>  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> -	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>=20
>  	return info.crystal_khz * info.numerator / info.denominator;
>  }
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 3818f6ae0629..dc71a6fdd461 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -40,7 +40,6 @@ static void __init acrn_init_platform(void)
>  	if (acrn_tsc_khz_cpuid) {
>  		x86_init.hyper.get_tsc_khz =3D acrn_get_tsc_khz;
>  		x86_init.hyper.get_cpu_khz =3D acrn_get_tsc_khz;
> -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	}
>  }
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f9bc1c2d8c93..e03c69a4db33 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -575,7 +575,6 @@ static void __init ms_hyperv_init_platform(void)
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
>  		x86_init.hyper.get_tsc_khz =3D hv_get_tsc_khz;
>  		x86_init.hyper.get_cpu_khz =3D hv_get_tsc_khz;
> -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	}
>=20
>  	if (ms_hyperv.priv_high & HV_ISOLATION) {
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 3cb473cae462..0a3bd90576d4 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -390,8 +390,6 @@ static void __init vmware_set_capabilities(void)
>  {
>  	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
>  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> -	if (vmware_tsc_khz)
> -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	if (vmware_hypercall_mode =3D=3D CPUID_VMWARE_FEATURES_ECX_VMCALL)
>  		setup_force_cpu_cap(X86_FEATURE_VMCALL);
>  	else if (vmware_hypercall_mode =3D=3D CPUID_VMWARE_FEATURES_ECX_VMMCALL=
)
> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
> index e24c05ab4fae..ff173052cdce 100644
> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -255,7 +255,6 @@ static void __init jailhouse_init_platform(void)
>  	pr_debug("Jailhouse: PM-Timer IO Port: %#x\n", pmtmr_ioport);
>=20
>  	precalibrated_tsc_khz =3D setup_data.v1.tsc_khz;
> -	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>=20
>  	pci_probe =3D 0;
>=20
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 4f8299303a19..35a879d33e9e 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -138,7 +138,6 @@ static inline void kvm_sched_clock_init(bool stable)
>   */
>  static unsigned int __init kvm_get_tsc_khz(void)
>  {
> -	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	return pvclock_tsc_khz(this_cpu_pvti());
>  }
>=20
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 1dca9464b41c..676910292af7 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1541,11 +1541,18 @@ void __init tsc_early_init(void)
>  	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
>  		known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
>=20
> +	/*
> +	 * Mark the TSC frequency as known if it was obtained from a hypervisor
> +	 * or trusted firmware.
> +	 */
> +	if (known_tsc_khz)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +
>  	/*
>  	 * Ignore the user-provided TSC frequency if the exact frequency was
> -	 * obtained from trusted firmware or the hypervisor, as the user-
> -	 * provided frequency is intended as a "starting point", not a known,
> -	 * guaranteed frequency.
> +	 * obtained from trusted firmware or the hypervisor, and don't mark the
> +	 * frequency as known, as the user-provided frequency is intended as a
> +	 * "starting point", not a known, guaranteed frequency
>  	 */
>  	if (!known_tsc_khz)
>  		known_tsc_khz =3D tsc_early_khz;
> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 1adb44fdddb2..487ad838c441 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -43,7 +43,6 @@ static unsigned int __init xen_tsc_khz(void)
>  	struct pvclock_vcpu_time_info *info =3D
>  		&HYPERVISOR_shared_info->vcpu_info[0].time;
>=20
> -	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	return pvclock_tsc_khz(info);
>  }
>=20
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>=20


