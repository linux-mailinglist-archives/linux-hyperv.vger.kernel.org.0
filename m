Return-Path: <linux-hyperv+bounces-8750-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEPlKpwAhWnr7QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8750-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 21:42:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE7F739B
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 21:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAB5300CE73
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340A32E690;
	Thu,  5 Feb 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aIoT6nf9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012056.outbound.protection.outlook.com [52.103.10.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3E32D7F9;
	Thu,  5 Feb 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324122; cv=fail; b=piQiPLb1ws/3UH3atNyxAc6EPoFWdhfZ4KMqbcGVDnxybhQnjIeFR9nrB8zG7+/E3q5RxZCiLZtdlZDNEjWssPE2DZ+bBaL0x+lA7vh7YyvRYBgajJohnnvUqCTbaTnftEsYwnLZDDsrTNnQVhE385eZUJ269PP9fLZ3MJgjK/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324122; c=relaxed/simple;
	bh=vMWhc957xtKl9skrrO71+AFte+5p8y0DFe7Wf3IQxSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3yqPi+eMHNhNtfduw4St762k5PTBgOa+pjYnqHN/d+sgU+R4LipI9jOez12ourB90oT2ej418aSTgQGW86NRYVhNaZ/M/dvXJXx5J5GXrRNHeMYggQ7Q2naHUPXOIHnRJ7LJkKFmqg2h899RYM0GafI6JnttDwMFPwLlQlOEvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aIoT6nf9; arc=fail smtp.client-ip=52.103.10.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZcVeE0tfZoZirJQCCEwHbS+07bVoTY/Z5VxQxmsSfFJFJJUQZUhOb/+ciDo95I8YlDZngdYGBORRNvDs4cZrAYAkQUh86zmKTdxKP3l58wh2QT+OSRcTMiDuqsy6F7lBdSaYHty61wyreHLRrgaONLhtgdCedrhxSxy5hH8gSmJcUNJIIKjUIBOtKPulVu1y6fsFzhXbpMdE/16+RTeb4lvclI/ZKNPO0BPOSPHdAGdKBIIXDgMeylYZGDmQyJeCEIiuVVDRGyfKfpqCGQpwIa7YPsrAn8zo3BYShgSezcRjaAqedzUpeARo/IDu7gNiG6cXRjmNv5xZn/lnCBH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhtKU829ytnfuF/Q8hXHRwzpxhKeUQVu1qUSRNAvOs=;
 b=YfZX//NPhJCYApQieeaobTFduGyj89kJyEvWcsQTdDtVW7ieMq26hruuayoXpt8nM/dIdalNiFS81TCLEwY7+nlXq9xZkCzAkMi1oBG2+SKB6Tpxy1HuoE3PzwMJQ8b6fwixjpPyXnF+XL7Myo4cBrCsOGFn+zzZsyh/9B/Hm04Dt2vS8IqI4r8gim0Ii545HFi48P3722Bom23txZmlA+tw1DgY5gj2Bx9AqGd2/VvZWEy8ffhCXWpp9NHU1/7dO3Zq7soQzn2/LmFbkiAw0TKAGsHhq5L5YYg0lhZOpk7WgPIRt/OQvgtS3QV/c0bjbZsE3oW12Wy0qJPdkD6qCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKhtKU829ytnfuF/Q8hXHRwzpxhKeUQVu1qUSRNAvOs=;
 b=aIoT6nf96Lt0gbnpl2sCF0XshSjfFQizf17/5zAfKhgOBOIh0DZ+U2RN50uPRGLmxSCY4Qi5os6DaqfMaIhn742zTw6p2145dy0RZGxziDOAfJ9sl8cX/oH614J6O7XD4LjauuyUUvF8Vgu6nCN+L49ffT42SzsHLXnJJ+pOwDQ+Qgf9o5k3Rtev8RPiK12A5U5IIsixHE47xD2lnc+LL3qemuV1qwsJA2pcdT6itDmLlaLGjZN/otJ4nNTwE6XK7gj2I/QZVcGXIPJ9eVrjEwlXlbEpGGV39AI59ms6gmo3FvLmN0pVLIBlrFZMiyILjhnEVhYMDDp4yfgjGaDiTg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB10664.namprd02.prod.outlook.com (2603:10b6:8:203::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 20:42:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 20:42:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Thread-Topic: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Thread-Index:
 AQHclGTjfuUHRH1hI0mR1MgYgqXlO7VvptmAgAAPmDCAAAwAgIABh5WwgABu3wCAADF/cA==
Date: Thu, 5 Feb 2026 20:42:00 +0000
Message-ID:
 <SN6PR02MB4157CE19B5361D9CF36F0926D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260202165101.1750-1-mhklinux@outlook.com>
 <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
 <SN6PR02MB41570BBE17C50675E94789FDD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aYDzU5ujoBlzWaa6@skinsburskii.localdomain>
 <SN6PR02MB41575CA65B0A07C935F85665D49BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aYKY0JmcnadPqwXK@skinsburskii.localdomain>
In-Reply-To: <aYKY0JmcnadPqwXK@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB10664:EE_
x-ms-office365-filtering-correlation-id: d4c1cf07-e742-4fb5-5903-08de64f70306
x-ms-exchange-slblob-mailprops:
 suo+AMQROd7KWLzCSB/8AXewUiiF+4xJuKBJQimJ2v7PT27GubgkFcQda4irbVcfsPqVP38zcrZO9vDN4F84PCMEj2Sqvj3d0FsmmZ3KJxe2PeGSTD29265SzYuB3odD5loPEa25OW8Cl+6Idv805NRci7BCQjh9QHNkURo26wM3sKch4sUcqtUoLTBaKKDQrVQmivQGKYpCe7cGz8QFObkN2GL01RV8Ed++MTIwCSq9CJyJhL5ko+2UoK5PU2tLLZa/P4hinF0sW01jKyv8wvPweuSrbmbMCWGtFGutA7JcU3qRqPOEVq8ozduocpE+RBq/roqN1pdWvcr1xFioZBhMgEqwki/xJ6XM6VXuIXGueMW+e9QkDoVo5dmvaqserncqcMqY2P0/4XqmAudSSGBYb2noQS29rvRUvRjGBkO12N1ndrGhtF08CYXRA4ucEB/hSPqnal+9Lk8nDNp6HXV5Ix+84sw+Gvsi2t3igcJw0hNVVYKCMtIv0c/ubDoRXDq3fFU1G5aKJOJq88+uLXvs3BkX/jWbOwljTZb9pLv1+YgqI/ionTljt/MGzyDLa+wN9MsiMX+UqWcxSjQQEJrEbvFRSvj03/aLQY94xTcHjyR/Scm8UCCTtix76YzAiKP1vlAEPPwWRf1zm5kS1k/6IM6TxEcqSk8fP3yZW8sx+fd3oxAWytfPiOl3G+P4klHTLeqRL+9wVpDhKraPgqnMGg+gaFlrFeoDTGBBDh0IjVQLUDF0+FIKc0M6roFbMKl7anHsCdmZeDpjsvMauKmV8qBngzENDWfEc/+mNNI5/m29GtOmxpUy6CF85HexriQvAmXWrIQ6sF4rqgcb1Q==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15080799012|41001999006|8060799015|8062599012|13091999003|51005399006|461199028|31061999003|13041999003|1602099012|40105399003|56899033|4302099013|3412199025|440099028|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O6tgLz0KrGT9U9Q4LFxYlR9oQgWg81tf2GZDc5kRHb+P451gqQPrjRqHL0a4?=
 =?us-ascii?Q?qw/4Ds7WWAEnJh5gvNeo+B+sKgsuMHObaxLhOELjaeljjj/c2eOK3RlzEQl8?=
 =?us-ascii?Q?FdabGZHVw+TNv3A/wLnKSGuJIsdImwt3Id4M106Y9VRnkS2tE438jRg0656A?=
 =?us-ascii?Q?5K8y62r5XwZI6sYURTa//FeEorFkyycY3If18h8DS+CVNJhX0tsF+H0ZMGBr?=
 =?us-ascii?Q?SkczvhfwQyE9DDRctK+SkzEvhu80Fh+cj7qQB6xLp92N6go40U/mPAH4J+6L?=
 =?us-ascii?Q?ZClH067HUflIYZGnMHXyMhOVMBbOv2j/q39ynRDby+0pNjhQg9XsHBmrjeN7?=
 =?us-ascii?Q?Bbu3GI3tSKm9FxBNifKIoIomb3DQ0jBJvP7uzxJC10bS41ZZSiNMETtaa2Gg?=
 =?us-ascii?Q?bAeDuohdHrQ320PW9Ec6un6pHZbNP3pKePBzHR+ybjyzNH2+fFHfbdypzXVd?=
 =?us-ascii?Q?ecvV25qC7oyLC8AeW/Sd5yXNMCODYgKut3Y8taMbX2HvIBgjzzCa74WF8ih4?=
 =?us-ascii?Q?erPkARpGsH2UU+Pz+8YDjNsvERl0/ELW0lRIPI8TLdx7WAEUrqKuy+3UiXUZ?=
 =?us-ascii?Q?XDHhVcJ7fczGyQ/IuvhDQlTUQNdDgT+XkaCdTo0ak8Ao3N8D0Ywp/E7ot+oI?=
 =?us-ascii?Q?owHMaLwPCcnabmJXP1S+4SDwR6A+LuREuin5w6vkTnBWCjtBatdhXzsZeevZ?=
 =?us-ascii?Q?vYwmYYkuDsY+s+XFCZvv/hNeTax+5UNalk5sQ9Zu0ji2RA/5ZaK1PWKmRO4r?=
 =?us-ascii?Q?sFyeUI9+a2Tsu5EJ4w5VHSW0KLNxaNRv4wnlSWcl2/gYPqvPbCKmI1m/hoFd?=
 =?us-ascii?Q?/1wmnedm3aWWyJKgHEwca85B9oJifPgYRE2bya9khcKJ1DABR9Y07vhg+VWf?=
 =?us-ascii?Q?ofhkXr8EslOk/qd60jEcgYxubzXzR7Loqtsrkc96C5DUqJxpowaK/HH1Geo3?=
 =?us-ascii?Q?jnG4Vnk+8KFsMLBUTfFTAfCac3qQHq3yTv55whKuFgMdZQM3ksVs4bLs1+bp?=
 =?us-ascii?Q?a0et5pSe6tfViLXAf+xliP8iQPaGDLawWifcLNRh1A6dEvQnl/en7ptbTZM3?=
 =?us-ascii?Q?lOiRNXKWYjH7FjpswoXBPbft+QshboRFqPFPcMwA6TeQuxRC/5jEimLT157e?=
 =?us-ascii?Q?esle7zjfTRVX/c51TNm6hpvOeT3iXitwQr369ci24MBUQgxkEg1hV+VV8OFq?=
 =?us-ascii?Q?htqukRKC5NiVUbQ3ktoHSoWssLrOyzvCgnQZzN4Cdm0IVDOhuZ7ZOzYLLehI?=
 =?us-ascii?Q?/VcFV6LOOQ0/rdLaS/g38gQ3FFmUow4PbqwnywQndB+LtJLGeyhBIFlYjsXD?=
 =?us-ascii?Q?RU9DoBUCNoyTXkSfWegij9Rver4LvxgQtpoiopkQnJUqO+U1Gk9/J7pqVDaW?=
 =?us-ascii?Q?IizFer+Wa6ADoJCoCoD47+Q810CW4KxucWg8rr53XIvhK13OQEe3ZS84F51x?=
 =?us-ascii?Q?QCLgT+euJcmRyV6TR/cRS1QUJ1fN7cYk?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WG7QbcpkwDHH2mirrsmYQpTavE7b0wp8c8QTP+pEl0U3VQfxiL7Coc3ei3gE?=
 =?us-ascii?Q?vNJ77uEfl3EQK5TNO8yeMjp/aRLVQ1iM7wNRU9A3zAtbMW4UXoRHBCqVzWuz?=
 =?us-ascii?Q?lw3yAakzueZCgfjAfXR41tX+exbl0CjzlnvvwgB5BRBWuhlg9XtvNXJtRRYa?=
 =?us-ascii?Q?MDpGOCx6S1aIt2DqOg0EOnf2d7+0plAYRDf1lcv91BF6SOJf89GK/TlPdbgi?=
 =?us-ascii?Q?0DQT86sX8p8JERP0GXrWdBd42rVcEXDJQAUncoIv1qbINzFYyYJJCLlf4vk7?=
 =?us-ascii?Q?WT9IMBXstrvbC63zlfj+MD2xrD1w0NarDBno2j2CdyNbvWlDQ0ubhsEPLQre?=
 =?us-ascii?Q?yUx8e187dB7NNSCyMUJsOFxqlzWCTd0V46bc+QZKHb9uiEEV5xBeSEN29C0J?=
 =?us-ascii?Q?XG3a2rbzPwUptWb2Os5ksDPV9iHYwh6mNzSYmeE2FS9KQOwxxbtfNeZXWTfG?=
 =?us-ascii?Q?vBLdcOx3hehzLENy6H1Gj86WevS+fGr2aYLvGlTPKPTMfKM7gAg+aKN+l2MI?=
 =?us-ascii?Q?gI3FNU97Tl8k5ixjlij5Td7EKcwHwrpHPQQx2a3S70KoB2T+0YoyVjVbjdwb?=
 =?us-ascii?Q?Ge3NBqmguFvvIG/tLchT0N47yu69SZ61PdEePnJPlu+aCr6g1gkQLLy8a8R3?=
 =?us-ascii?Q?UeiT+4O2ehIkQKpzsHopSsPBQevjxozsX1oOhaVreMmw8zXp5oX4Z0Q/9Ji9?=
 =?us-ascii?Q?fWukEjngPu3WGLz6rr+LMtihfNGpE6pLELGUWzaUQZ01PTyMdVlbZFfDlJvz?=
 =?us-ascii?Q?IctmRYKJUoKzO0QZgjc0jdhp9RdkaAN9bH2kIujJ1jPOhgekkl2s08hwZBqb?=
 =?us-ascii?Q?suoaEAyuANlhAX8N7Y9wH473TbtsQ6vFwpV7OFRZylsxTmD9hkDTzWmjCfLz?=
 =?us-ascii?Q?OTvxAz81eir6pWxj+U4L6gmaNnAr+caOQcdULCNHJFuj5pe+VeUtGSwD2luP?=
 =?us-ascii?Q?dogVybcCM1izhvPI+bYVvq35Ws2weFjxwQIG8o18+kWfty8FYY2uM8MUxJNY?=
 =?us-ascii?Q?RdDWdg//B16iPbMMPuBbA3TWi3sGYNESRWakLyxiR9EA8WxNsWVkkByWsVqn?=
 =?us-ascii?Q?hg5fN4+3veOa/nNhYllDKCD/6WkOhExHSRwrYLAtXWfTSKEIx/6DwpFVubL9?=
 =?us-ascii?Q?LTqK23T7te4q2cdNzTVgYORKsTUZFgBEkLKFJ111Fmx0qpuZZMIDfXCb7hjr?=
 =?us-ascii?Q?0QhlFdZfqgHaEbGGZ8yFPwqeUJWtII2WFRJr/oMgKiV/JNQ5kR3Y4C+Zwo3W?=
 =?us-ascii?Q?+OgNa6tc5G4+dEX5EgkS4A7LjzinJbzUaNvZcgG9kYNB+rgS82ujSAFo65wH?=
 =?us-ascii?Q?MsvlLqGIKDicSW98QhQ34J011/x6jnGkvdrEoIhfAfpgqVhS0bSw+8t4+LGL?=
 =?us-ascii?Q?bk1JVzwRoe8nDu5iCVJ4l8bUlYswehzEUxMxmzpF/EjArwFvdBIRPJ3mfPCy?=
 =?us-ascii?Q?SejKBgEbmchLTQ9SsOB60NTPjLR0RvMi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c1cf07-e742-4fb5-5903-08de64f70306
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 20:42:00.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10664
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
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8750-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ADE7F739B
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesda=
y, February 3, 2026 4:55 PM
>=20
> On Tue, Feb 03, 2026 at 06:35:40PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Mo=
nday,
> February 2, 2026 10:56 AM
> > >
> > > On Mon, Feb 02, 2026 at 06:26:42PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Monday, February 2, 2026 9:18 AM
> > > > >
> > > > > On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wr=
ote:
> > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > >
> > > > > > Huge page mappings in the guest physical address space depend o=
n having
> > > > > > matching alignment of the userspace address in the parent parti=
tion and
> > > > > > of the guest physical address. Add a comment that captures this
> > > > > > information. See the link to the mailing list thread.
> > > > > >
> > > > > > No code or functional change.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@ski=
nsburskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
> > > > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > > > ---
> > > > > >  drivers/hv/mshv_root_main.c | 14 ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root=
_main.c
> > > > > > index 681b58154d5e..bc738ff4508e 100644
> > > > > > --- a/drivers/hv/mshv_root_main.c
> > > > > > +++ b/drivers/hv/mshv_root_main.c
> > > > > > @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct m=
shv_partition *partition,
> > > > > >  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> > > > > >  		return mshv_unmap_user_memory(partition, mem);
> > > > > >
> > > > > > +	/*
> > > > > > +	 * If the userspace_addr and the guest physical address (as d=
erived
> > > > > > +	 * from the guest_pfn) have the same alignment modulo PMD hug=
e page
> > > > > > +	 * size, the MSHV driver can map any PMD huge pages to the gu=
est
> > > > > > +	 * physical address space as PMD huge pages. If the alignment=
s do
> > > > > > +	 * not match, PMD huge pages must be mapped as single pages i=
n the
> > > > > > +	 * guest physical address space. The MSHV driver does not enf=
orce
> > > > > > +	 * that the alignments match, and it invokes the hypervisor t=
o set
> > > > > > +	 * up correct functional mappings either way. See mshv_chunk_=
stride().
> > > > > > +	 * The caller of the ioctl is responsible for providing users=
pace_addr
> > > > > > +	 * and guest_pfn values with matching alignments if it wants =
the guest
> > > > > > +	 * to get the performance benefits of PMD huge page mappings =
of its
> > > > > > +	 * physical address space to real system memory.
> > > > > > +	 */
> > > > >
> > > > > Thanks. However, I'd suggest to reduce this commet a lot and put =
the
> > > > > details into the commit message instead. Also, why this place? Wh=
y not a
> > > > > part of the function description instead, for example?
> > > >
> > > > In general, I'm very much an advocate of putting a bit more detail =
into code
> > > > comments, so that someone new reading the code has a chance of figu=
ring
> > > > out what's going on without having to search through the commit his=
tory
> > > > and read commit messages. The commit history is certainly useful fo=
r the
> > > > historical record, and especially how things have changed over time=
. But for
> > > > "how non-obvious things work now", I like to see that in the code c=
omments.
> > > >
> > >
> > > This approach is not well aligned with the existing kernel coding sty=
le.
> > > It is common to answer the "why" question in the commit message.
> > > Code comments should focus on "what" the code does.
> > >
> > > https://www.kernel.org/doc/html/latest/process/coding-style.html
> > >
> >
> > Which says "Instead, put the comments at the head of the function,
> > telling people what it does, and possibly WHY it does it." I'm good wit=
h
> > that approach.
> >
> > > For more details, it is common to use `git blame` to learn the contex=
t
> > > of a change when needed.
> >
> > Yep, I use that all the time for the historical record.
> >
> > >
> > > > As for where to put the comment, I'm flexible. I thought about plac=
ing it
> > > > outside the function as a "header" (which is what I think you mean =
by the
> > > > "function description"), but the function handles both "map" and "u=
nmap"
> > > > operations, and this comment applies only to "map".  Hence I put it=
 after
> > > > the test for whether we're doing "map" vs. "unmap".  But I wouldn't=
 object
> > > > to it being placed as a function description, though the text would=
 need to be
> > > > enhanced to more broadly be a function description instead of just =
a comment
> > > > about a specific aspect of "map" behavior.
> > > >
> > >
> > > As for the location, since this documents the userspace API, I would
> > > rather place it above the function as part of the function descriptio=
n.
> > > Even though the function handles both map and unmap, unmap also deals
> > > with huge pages.
> >
> > I'll do a version written as the function description. But the full fun=
ction
> > description will be more extensive to cover all the "what" that this fu=
nction
> > implements:
> > * input parameters, and their valid values
> > * map and unmap
> > * when pinned vs. movable vs. mmio regions are created
> > * what is done with huge pages in the above cases (i.e., a massaged ver=
sion
> >    of what I've already written)
> > * populating and pinning of pages for pinned regions
> >
> > Does that match with your expectations?
>=20
> I'd rather suggest something simpler for the function header:
>=20
> * What regions are created
> * What pages sizes are supported
>=20
> I.e. describe what the function does, not the rationale or the
> architecture behind it.
>=20
> For example, something like this (suggested by AI, feel free to rewrite
> completly):
>=20
>  * Depending on the request, the region is created as pinned RAM, movable=
 RAM,
>  * or MMIO. PMD-sized huge page mappings are supported when the userspace
>  * address and guest physical address (guest_pfn << PAGE_SHIFT) have matc=
hing
>  * alignment modulo PMD_SIZE; otherwise the mapping is established using =
base
>  * pages.
>=20
> The rationale and architecture can be put into the commit message.

I really disagree with the approach you are suggesting. In my view, putting
a detailed description in the function header is completely aligned with th=
e
"Commenting" section of the Coding Guidelines. We're not in danger of over
commenting or commenting on trivialities. My goal is always to be as helpfu=
l
as possible to whoever comes next in reviewing or updating the code. I
think that's putting the information front-and-center in the function heade=
r,
or in comments within a function to call out noteworthy aspects.

But we're at an impasse here, and further discussion is not likely to resol=
ve it.
You and the Microsoft team are custodians of this code, so I'll stand down.=
 I
can't do justice to the approach you prefer, so let's drop my patch. You, o=
r
someone else who can embrace your approach, can submit a new patch that
does so, and I won't object.

Michael

