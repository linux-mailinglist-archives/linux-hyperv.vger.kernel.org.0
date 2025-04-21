Return-Path: <linux-hyperv+bounces-4982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA7DA94CA3
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 08:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50AA1891D1A
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33029258CC9;
	Mon, 21 Apr 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="beTBFRyu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021102.outbound.protection.outlook.com [52.101.129.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B9257448;
	Mon, 21 Apr 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745217241; cv=fail; b=PSD6vVDG0jv2gT5ZbL8e+xsYO7qafMoPrHqbs0bRiRbAZygNNsuA5mzj+WNr67ElWLsI8vKwhQu7zlP438VTx44f04vLmT+dgyBx0WGEWwuEUT+N8xKfu9B1kpa3a4iImoe9qOnFbG9rsziEz2bt5C8+PLtjvsTF4HoD1eFmPh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745217241; c=relaxed/simple;
	bh=+8GAxLwVBMX9E9zw3Aq0gacD1z9zmLe+xHi+GLF/VzQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikBthHFEuQnL4SKxS0qvoI3lmT7O/9GMSKy7AeUjK+ysPVsgH6AqXiaJQJuqPvpG4X2sULRHiWGAJPWfp8GSCRB5OsYtVvVyg8cFKTYZmmES7tTozYpLD8hAZtxGu6cHruvx5NP8kHWBrpq8UqQAlXt81FcRE+FeoisU1+Uns7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=beTBFRyu; arc=fail smtp.client-ip=52.101.129.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrll7gMKM9upsOaxL04YzCr6LWR2R8zPM5a+W7/JiSvEJ0BwIPLquQ6tKigkrlSgQzajNAAGAOMPSTA9zJu6k9r5YvuJ+zuEGvd/oUgqcwMEGjUe7lh45CexBVJwSy9TyXqxb7BeMJja3HpnzewhXSaXwuEDT3llaawYG+mdRaJguZNyuNVtrgQbM6e8B5qlRmUMk/BGcdcVmQGWUFo6DeTwz6e6H0J2jtixoFSOgUBL4+fhWxVKezgEIt+8+GAmi8tCOlBaJ9RRL2UH7hbY3DC+SgUpyBMNuVGFXDhIZJZ3xlmrn/NN643oHc20t9VZxRcX7Gx/kAaKukraYMBvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vec4ljujBmV3wXUBWWBm6HX6xspU6hmbzbkikotQP8=;
 b=o2wQC+UwpwKaO/HXKKVuMcGdMdShEyEuxbZZJbMKuRReE+1HVzGVOG+CkPcDtWkl3K7zy/V4J8GKDxbI1nXByD3CkJ64mejvO037w1d9+6DK9MfUXswn220LWu/6sYLAU9BB5sHlCYnQb+Nvgr2+rMUYU+biWfK1cYq+Lauz5/LpdmzRV8/jJFEgIXdCbWSFkc7lWbSkrMc3qRizXQGlBAZx6SaG3BfVkC3Xec9h7kCrd6RuIgjdtOY6xci0KL535aanJece23zBp6XDANUws1JOt3cc9PxhJbGeKR62pcXqtW7tsScZldCIPFpgUHigBqOzFMCzEhRkTFcJxw8Z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vec4ljujBmV3wXUBWWBm6HX6xspU6hmbzbkikotQP8=;
 b=beTBFRyuU+fR0K7WHOfwkku8/MWB+AS2W4XfQHnh8K9J5KG8BpAjEj1UMuxkS4VgiwxhGfga2Se0V10FDm90STqU4ot6erUy5mM4tA3ZNlYuOX+tTkUc4D/3YAMYGgSSGoPx9CeOHXMtVA3KcTcdtPfkLVLNJJnBgd69v+vxOXs=
Received: from SI2P153MB0735.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fa::8) by
 SI4P153MB1056.APCP153.PROD.OUTLOOK.COM (2603:1096:4:26c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.21; Mon, 21 Apr 2025 06:33:50 +0000
Received: from SI2P153MB0735.APCP153.PROD.OUTLOOK.COM
 ([fe80::34f3:1836:ec0c:986d]) by SI2P153MB0735.APCP153.PROD.OUTLOOK.COM
 ([fe80::34f3:1836:ec0c:986d%5]) with mapi id 15.20.8699.004; Mon, 21 Apr 2025
 06:33:50 +0000
From: Shradha Gupta <shradhagupta@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gupta, Nipun" <nipun.gupta@amd.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan
 Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, Kevin Tian
	<kevin.tian@intel.com>, Long Li <longli@microsoft.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Maxim Levitsky
	<mlevitsk@redhat.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: [PATCH 1/2] PCI: hv: enable pci_hyperv to allow dynamic vector
 allocation
Thread-Topic: [PATCH 1/2] PCI: hv: enable pci_hyperv to allow dynamic vector
 allocation
Thread-Index: AQHbsodXVlJCrSlsiESgr5lCIXEiMQ==
Date: Mon, 21 Apr 2025 06:33:50 +0000
Message-ID:
 <SI2P153MB07354B3C1D0FD751D6331D9DD3B82@SI2P153MB0735.APCP153.PROD.OUTLOOK.COM>
References:
 <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1744817766-3134-1-git-send-email-shradhagupta@linux.microsoft.com>
 <87cydbrttv.ffs@tglx>
In-Reply-To: <87cydbrttv.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-21T06:33:44.624Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2P153MB0735:EE_|SI4P153MB1056:EE_
x-ms-office365-filtering-correlation-id: 38d0beb1-f396-4639-ba63-08dd809e7a59
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?ZE6+KyooFLluq4wRZhJMKqadOkASmEbfi4kNsyAiixTIRIpK+6XjfHvuLc?=
 =?iso-8859-2?Q?Hpqx7/1j2EJMvIcUkLx29l6Bng9CQwdkPYJw5qzrm64kZh6757R8LlPxlU?=
 =?iso-8859-2?Q?UepKDwfNP0ogPOuJjGe9PSO6KnGh0hIUS09np5FW8BnJe6Zq/rJjqA/5D7?=
 =?iso-8859-2?Q?dDnIb4MOI7CsdqTqw5vcfjfA7tD5NAgeYWveEedtIRDQNOeK+p1WVXW88S?=
 =?iso-8859-2?Q?XXJd6Cs+smmv60RUN5r+xvHTzB5U290TU4iKnQqVPjiesqcgvYfBCNj53s?=
 =?iso-8859-2?Q?pmWVp9vYtIJ/OWjwYHTaZq4GqI2K/c/wx1XLPNJwHmjirjEbaqCGXuGfnq?=
 =?iso-8859-2?Q?Au9AAAejH5pyE1M4xnCX9e1IHYUD2tQ15z0wOTHRWZkJkWaZny+uAhyq58?=
 =?iso-8859-2?Q?a5+H65eepfXCzLRvXYjodR8ZxlFryn4K8jSuPMCqKNOK715g9ua/ycRMkx?=
 =?iso-8859-2?Q?nuTY91bNnxM5JoeNIR+hRnOYcHWqdT/Y4HpWlvZxji9NmFNoKzNN0KMsjv?=
 =?iso-8859-2?Q?djI8+TZryWPNDSrRYuWN/JnRqmZjdWbwqFkI5nfC7dU0BWgcncxGMs0ly5?=
 =?iso-8859-2?Q?UtuXZvHEtybAr7r+eaoQ0vkYanzZWG9zCbqSUmGLytANfacr66pstWvaFE?=
 =?iso-8859-2?Q?A9ptUn2pmz/PJEPsEK4tjpNQ/raBOT94jMopt2iPAo/VaxMVTy4Sw7Qu0W?=
 =?iso-8859-2?Q?opzHS6czeFw+hihlW3J0a83slhliHh9ZeIB64MPxaOCBGYObEumxPccsk3?=
 =?iso-8859-2?Q?pFy1F2mXPrVE1bQjWald5xALloNDFqlIlpJDOsbgL8fj5HQVaFOHrZJyH/?=
 =?iso-8859-2?Q?XKbs6ndOBuZKAg38jOVM0SJqHgJ1W/yHt8yIMPKjhybjb1UMIe8Q/5g/zT?=
 =?iso-8859-2?Q?Ybeo6AWSPyyKVKKdKiVt8hpFWJt8uw+SZaQyKk1BQBk8SGrGa3FMOa5at0?=
 =?iso-8859-2?Q?vDKCFRrnb4l/2vagZBT+banwo10R240/xXNCeLIxaPo8RFR9WjjjE0wV+e?=
 =?iso-8859-2?Q?WzAdL8GpinjLjDLzJnSMsNM/fVmv+V9NHHLWuLH/6SN/rahFZhRi6bLRGo?=
 =?iso-8859-2?Q?d9jxEW98jiW9pYQ/6ynhVd2bwVFuSAErboCwJayM6SllS9aDmLXh09M08y?=
 =?iso-8859-2?Q?do9hYWTZNaTD6ul+vRJVQF0QqnARA9ElMIhh9x2zuwX7tOMtsBhjLc9nAS?=
 =?iso-8859-2?Q?UprG5D8Rso2CV7ulWZyAKkM0pQn/dSy6OwnZPgccOjtszGb2Ag7AAYQ6b0?=
 =?iso-8859-2?Q?heWJB8S1HpNxuvdDrho02tT6gYy/8eB5vXv4vN0Icplbs1nABVvVuZKWor?=
 =?iso-8859-2?Q?VWHwXjkfIC8+/M/3W+oHfnynyO47nkr4O0521VFG5vJiHzXZoXFSWpxNPp?=
 =?iso-8859-2?Q?vvLbN7taWc3HZJ4sKuwWIuMaYlT3tsFM/tKc+zYRkJsJywnr/OiYMydMg+?=
 =?iso-8859-2?Q?w6U7ws07Ru5uEv0ebkpVIKYs+rKJKYwzSkK7glBTRELV8VgEdWNvFyFhr8?=
 =?iso-8859-2?Q?yzoGgcmng4NimJiOu83B/LT21AwMXUDN/1C1SkbwbVnEYVS5LB3bNcsAFK?=
 =?iso-8859-2?Q?9q8e7oLlK4skqG4pMCz1YbqiTw0J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0735.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?46b8cSRFkU5OwPq5k6mwM30StyxqeYlmuW45zYzEBuZM6X2f3R2YNG6wv/?=
 =?iso-8859-2?Q?budUFzXU3idiytHtXHTzQYiDd6ksYnFJfLZJmfAi3W7U6/AlgLkdNXBu2z?=
 =?iso-8859-2?Q?xRHRL4vXSlNFmOlec6B7JqGrgJjz2cs3XBXZdYvYEtsDMczbHsjtnrqb/p?=
 =?iso-8859-2?Q?aN4CGe/iIokraul+j+mdLvGWkFdMP7sjeUJTZpdhfGVlXHDWiRvuLf6Naz?=
 =?iso-8859-2?Q?UtcYOqu4Oak2IowV9D9+lwpLI8BKLagW51CVDZlqdwOF7qATAZvEGCgtso?=
 =?iso-8859-2?Q?zDO6zmg2FSdplAbjzkknHklBA0uHE/pcUOtPTsybpqutqXIe4Ot7kc98dP?=
 =?iso-8859-2?Q?RkllvMGJv8Ci47qFkJXA55L4dFN23WAAWmPfTZzI2HoYBKdz00H/D3P6x8?=
 =?iso-8859-2?Q?2HLG1RcK/C8SsMxVA2lbDB9+eXeMbx5S5waMacq5hVbWRbkWIEQaBGdJv5?=
 =?iso-8859-2?Q?5c+Z8XVHps6AsQppfswdHdiTdK3lfNPmziBujNebEOpYi4hrPet8ct5aw1?=
 =?iso-8859-2?Q?xfUf3TjyZ2dmD8FvpI7H3X9jy8gsp1UjklycWLSUyLmaLujVF72HWvVtzR?=
 =?iso-8859-2?Q?fx/XkVSqHBECtKGCyocGGI3I/UYeyW5SSYeQ+YYLBe3aTK83UWsVZajLLy?=
 =?iso-8859-2?Q?7K65Z4CAvKMXgoClEAcGY35wjaUpHMteYXRXzzV6eJFrt8q2DZwl/k3Hwq?=
 =?iso-8859-2?Q?utTGNQY3QgQPVGhvf4QEkbxzETbGBP5YMv/XVaxgU5x98DHCoJiJsqqDyG?=
 =?iso-8859-2?Q?Sy5/n795ZWiwAuzHiMw9GCX3M5HH992zWmrUFOFChtW1uAjXa03i0ruujg?=
 =?iso-8859-2?Q?kx02dTVNyDhrwBcAX992tBLlaO1fDWsE2Wn9aBCE8od3Vp3+AyRGVovPN+?=
 =?iso-8859-2?Q?1o6U2tNDADsgoHyIOFCdH7Ntqe6XQYPRtO1u8gZNI1IVyUjnXhBV2YqngW?=
 =?iso-8859-2?Q?4vjgQsfSUKltMFscbInGa9gy9MxgMowucQfT8LdRF7+WynSOdVSblJwEeq?=
 =?iso-8859-2?Q?N/Hho/Gr7wXQF7UXIvDVXpILJC9gUIsbetkMls79rsbWwIL9pH4FkvS9Cb?=
 =?iso-8859-2?Q?8D7yJwMrGJASN7sD+91U5P5GFB/CfEkkSbVJKfI4CyOOuSfhPZSowI26pl?=
 =?iso-8859-2?Q?HNfXD1yXp8QffQNWPHl8woPCnV2rz3PRghgidTh1+Wlg4b6ZdiSv/9SP7i?=
 =?iso-8859-2?Q?gy0FP9p3cXPKEVTdpXlxEmv0OuMlZu0SPrjOXmhUr51TtnExAY7GgMVXuH?=
 =?iso-8859-2?Q?QwjfoN0b9s4+ma1+6ozhDx8Uenp6cuMQAor9dSgvdIlUqifXfXdU6aoCWO?=
 =?iso-8859-2?Q?1BpDO31amELYpedYn27WgVMdPR+bV3FPjpjJa28mcd1QiiihUJacwRTaPq?=
 =?iso-8859-2?Q?vetkwTkd1y/nBBcPFtONN+5gX9bO2tw+pnPbNDhQ4tPpKQeLfXbWRU51aO?=
 =?iso-8859-2?Q?0+PYyM3jdutJ0qk9JN3QTxW7ab2X0GiXV+Tq07p2Jzf/VioSorvPyPnja1?=
 =?iso-8859-2?Q?9neW71cqlkkzElatYka0u7j9+mGWfNIUebXf6qMCZ2fe9CLuZU8PK0Lju0?=
 =?iso-8859-2?Q?S+yrnaY7SwjQjIpmiCbQsLM1BvNsq88bbYdzk8ydNX9D6d1FLcUlPqTv4m?=
 =?iso-8859-2?Q?gE0X7yXozbS/XKuegXqGBmzElxd+SAYqp/?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2P153MB0735.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d0beb1-f396-4639-ba63-08dd809e7a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:33:50.2236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0VTS6FV0wUh13Of8fP8YDnPzyuwZBoK/I8pqko2Dkiv0b2DywaVWc4gD15HMXd3Z6PCGujK9aDw0Js1O3mk//QaWDRmuEv4DcrDkBlqtvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4P153MB1056

>On Wed, Apr 16 2025 at 08:36, Shradha Gupta wrote:
>> For supporting dynamic MSI vector allocation by pci controllers, enablin=
g
>> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_des=
c()
>> to prepare the desc is needed. Export pci_msix_prepare_desc() to allow p=
ci
>> controllers like pci-hyperv to support dynamic MSI vector allocation.
>>Also, add the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and use
>> pci_msix_prepare_desc() in pci_hyperv controller
>
>Seems your newline key is broken. Please structure changelogs properly
>
>in paragraphs:
>
>
>https://www.kernel.org/doc/html/latest/process/maintainer->tip.html%23chan=
gelog&data=3D05%7C02%7Cshradhagupta%40microsoft.com%7Cb1abd0d5505243eacd4c0=
8dd7d96afa6%7C72f988bf86f141af91ab2d7cd011db47%7C1%>7C0%7C63880480845111497=
5%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO=
iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3%3D%7C0%7C%7C%7C&sdata=3DQ4YgrhG0y7n=
FuYYePe3QVydzUQJ2owKiqWZwLkZjCR0%3D&reserved=3D0

>>  drivers/pci/controller/pci-hyperv.c | 7 +++++--
>> drivers/pci/msi/irqdomain.c         | 5 +++--
>> include/linux/msi.h                 | 2 ++
>
>This wants to be split into a patch which exports
>pci_msix_prepare_desc() and one which enables the functionality in
>PCI/HV.
>
>Thanks,
>
>      tglx

Thanks for all the comments, Thomas. I will incorporate all these and send =
out the next version.
We are facing some issues with mutt, hence I am replying through outlook. A=
pologies
for the issues with formatting for this reply. :)

