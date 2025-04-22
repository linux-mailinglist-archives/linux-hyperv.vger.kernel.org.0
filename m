Return-Path: <linux-hyperv+bounces-5038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E245FA96896
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E9F7AADE4
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 12:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFFF202F7B;
	Tue, 22 Apr 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bO8nXtRj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8131A317D;
	Tue, 22 Apr 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323763; cv=fail; b=caaOhos9S///s7x/AARxkWyVMfa60VPwD4+zf8tkwOo7mO5OW9XL+wqkTCvXK7xsneWPdm9I5qmH5TJawFEZ7AyiLFaf4rcM9fI71rFNoKRl/pcF39EHLUrajh0eZYnjjWCGd/X3GqAr87zC3Y1SyVi1CgzHH42KHWba6dcKm6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323763; c=relaxed/simple;
	bh=lP0oURMlsAuUvTWTu/PuGsVjbfyl3tH7K8kCwezmo/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VibxuI1umYF2tFvf7fjdd6AZXBlKkp77ETJ9pGDLscX0C7cmVE4sLbdP9EXgQhApWGO6iiZudRDgjWyvPMqU/ZE1bh4d+96I1BDlLxlUFmaxQI83kfDv6ZuH3I55GnvKEcFeSIuOVwcrW9ewzSwWY2K9FSuwAeEmEbHrXSQ1/As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bO8nXtRj; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trmkFAOvm1Bn/zpoxQLP/hXdLhM9tvC2N675ziTNZp+iLpkKtiwSGpK+dg0jNf5F/jw8DBe/6wHdT3f9ctJZszQ7yd8HK+L0h3IerAZFN2wshsRX33+5rKUajN762EcAQU6f2oBSC4dCpTk50DbIIXucpRJlBRZv9EPTWFxLA0DU30YBC5ejUoLDwlJQx82QblUgJ9oP2qoOg4CvRlyQIfuj43+tCI0meS5fcIVwsHkvacHCwKxSYHmsVgikPYc+Oph1RGqeXt6r3N0mr/Zf7srtBumX3dc1ezXqya2SctB8GMHJXTzTNlgGn5GUCVtdTYmZX2n9DJT9+RPjpGtk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUJTovpKi6Vyad9tSmtvQpxhB6X9f0bvaUqOJkCMSHA=;
 b=UfIicA2uDaso+1PvqsAfvSVxVYsmyofe7D1l4Kt2tZ8L0+aS5PcSu2oxiZmGn5RFyU+71doV0JITx+2kts0BfQNdoxHsClvkyiRzBvUN4AVLihU3igBTz6UEgJQU/1a7t/yqWNwAnBD9JPkfgKPspBqbJdznwO+a/5IONsOJpcy9orGlqe8j7CrvUZB1N3HqAJAwG17u3pmtPCB90bHZtBqs91WntSD6uHyteOIGmBZTDJ5BorcCWrR60wNJiZSOv03IbYWfbCRIFrPF6u7+mFnoF6TkfA73juZZgxsK17Ty1vYqccnewAltMpS+mA+ZcbVuJ3KuskA7XpcdUUNr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUJTovpKi6Vyad9tSmtvQpxhB6X9f0bvaUqOJkCMSHA=;
 b=bO8nXtRjn00BCbU2qVKrfGIeJ64jhNnV1CPslnbq5Mt6BLd1PrmpX68wYUinJPAuM98Ht2iMWnfJD3Xgju4HsEevIJvyJmNO2EUqUGCBWILsh33MtIBcu7YclPDY84fcs+vl3Yic7y/0OICZ7JLFZ5o+HEDwqeB7/2yYCBkyMkE=
Received: from SI2P153MB0735.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fa::8) by
 OSQP153MB1232.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.5; Tue, 22 Apr 2025 12:09:16 +0000
Received: from SI2P153MB0735.APCP153.PROD.OUTLOOK.COM
 ([fe80::34f3:1836:ec0c:986d]) by SI2P153MB0735.APCP153.PROD.OUTLOOK.COM
 ([fe80::34f3:1836:ec0c:986d%5]) with mapi id 15.20.8699.005; Tue, 22 Apr 2025
 12:09:16 +0000
From: Shradha Gupta <shradhagupta@microsoft.com>
To: Yury Norov <yury.norov@gmail.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gupta, Nipun"
	<nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron
	<Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, Kevin Tian
	<kevin.tian@intel.com>, Long Li <longli@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring
	<robh@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Dexuan Cui <decui@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni Sri Satya
 Vennela <ernis@linux.microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector
 dynamically
Thread-Topic: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector
 dynamically
Thread-Index: AQHbs39dFrGbSgPzr02XXH2ybBvOEA==
Date: Tue, 22 Apr 2025 12:09:15 +0000
Message-ID:
 <SI2P153MB073566C9F7642DBDAD976812D3BB2@SI2P153MB0735.APCP153.PROD.OUTLOOK.COM>
References:
 <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <Z__nPAIE5kdFQRe8@yury>
In-Reply-To: <Z__nPAIE5kdFQRe8@yury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ffcfcb79-a04b-4d6e-9139-ef76bb880682;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-22T11:37:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2P153MB0735:EE_|OSQP153MB1232:EE_
x-ms-office365-filtering-correlation-id: df7f1a98-b3a8-4401-1086-08dd81968079
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?8VgkCuuzcJGvV2i9tGEa7dVqGSGWYuswe/R3nH7Oi/wgtTBrpK2k/0j4T+?=
 =?iso-8859-2?Q?Q2J+bIyxdZXcLxM48Yl09pul9wwY6Cf0mETuySh2yfFTUKB67eFeGYOOtq?=
 =?iso-8859-2?Q?hlCZgT5r9HR4TzbOqaSNCrzCWigM2Ov4usgAjpbUyjahW87RNUgE1kqZhw?=
 =?iso-8859-2?Q?FbkGVWOI8irbwY8eCPIQc27QnCvh7PTcMNqIt8dm3Mb2RBXjnAxxqsOlG2?=
 =?iso-8859-2?Q?hkgpHm9Nf9QzgHSYfyHkSLFluXXYopcuMMl79vicuXaXGigCnZjGXXC2Jb?=
 =?iso-8859-2?Q?8fJL887oCE8q1l55At6NPOrbvSIZapbxYgYmE/BJa74dWY/edldNr7Ksqj?=
 =?iso-8859-2?Q?Ltk+ClzE7ox9XX8i/+7GBAeImKFAF+uWRcw3nr/X7s/g47qD6zW2OHlBAO?=
 =?iso-8859-2?Q?NuCmBF5XoxozFeHf7vJZLcE1lCHJ5tkRYUz97WkfA6yciPNoXKERehlccC?=
 =?iso-8859-2?Q?XXC/C/9jOFOTdeVs/zrjoPY8J33qIw7ZpAZf26LSJCWeb4sVi2TMfDu7A2?=
 =?iso-8859-2?Q?2IJD8V8celStGcqAmG0RWaXfs5ANMIhe7/cKWZbAso8T2dOlgdq54mWIqC?=
 =?iso-8859-2?Q?mHncxLvEm3i/IHsbqmRM0ujTB805Lt+vFMFDWrZW1C2gGIaLy+boIB88Dd?=
 =?iso-8859-2?Q?ljeXMJs/HRoAtzT0TUfRPBmXveI4xlciA+LJn6mYOVmgoSkee3o0fMJNfF?=
 =?iso-8859-2?Q?s6LoO1kGIHvDNJ1XH6RdS0o8Hn6TKp6Y+8CM8G4vSQiGW4fJRRXscvwVEv?=
 =?iso-8859-2?Q?L4cgAzthiLqJdDDFPODuzOWv2cTbGpQdFMrEaSi2RZebFx9MbfCIvD7hLq?=
 =?iso-8859-2?Q?jHtJOxmzvmjemW0Fru9XKxRkimIeaRjZuSwSMzLg7oFSJb/HDO+lpYmy36?=
 =?iso-8859-2?Q?VPEUS+fW4aoHucRWPDITgGLNHtmwokLmRT8SOF7juTV3tf7ZQVAVSpbJiV?=
 =?iso-8859-2?Q?8IoEAmHpqp1w0ghhwRBRjgbzAtNBTM1ng2BogWS4SgodeSoVdIEjykiprU?=
 =?iso-8859-2?Q?oda46cRX1tPvBQbHeUGux9GIn5/Y5xdwFjOt3Sqf13IH2lU08fuE5pzv2b?=
 =?iso-8859-2?Q?tap26HwyGPe0dfBYIbnQ4nK8i1rlz5t3vwxRC/XQC9I9V4FLEGgbEjXYZp?=
 =?iso-8859-2?Q?wewH2qZTvUo2FINLdXVSpdQYZv+2lZ8Z8TGV9CEUpdVL2fvcyC6thO7T/B?=
 =?iso-8859-2?Q?SIisheY0Op8E96sQogMcDVzxM/5Pq6OuhybsvGeXYOU6bgQMEa/bC7Ee5Z?=
 =?iso-8859-2?Q?P5cz73+gubpfUMyAD/Z5ln+rVB/V2wKDX5FWDfmosAobCgWShn6M35g88w?=
 =?iso-8859-2?Q?RkHmO8T8LMLxqwRZ4wYALdQq9u7HF4c8Ze/fbyJHC76iKzLWRTY9CGMURk?=
 =?iso-8859-2?Q?6W4UQCXT49ijP9sSKNUmKP7U/Qu0Ov5Lg15n1mpdTZrZQcy/u8K6tCbnjA?=
 =?iso-8859-2?Q?vPgCNrO1YiV1AGVozTYouZrsRgN9Jt7bk1Ok7hOJb0xL0Uc61c9liXXiNE?=
 =?iso-8859-2?Q?FnB9vC5J84C09baew4VBbxz6NsB77WkHJCcJGCaFARAQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0735.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?x4VwW8hgvaVwJFtykXNecy49cqvMTHl2zei31bQMQ+ExH1nf5bGPyRc/yt?=
 =?iso-8859-2?Q?R8/nYJhj5RgAiUjHo89iPAUDQDg2NLNpw1tfu+7jSqa+wtNDmNbvGSA0I5?=
 =?iso-8859-2?Q?jk+XnA7D5Bk9HjQllfTsok8sClw+pQUEwMwifSQAhnfsJi4k6uT4pNlm8W?=
 =?iso-8859-2?Q?gWceWVhk0ogtn9lPLvbNNPl2ZekUHi8ZLYJobjr7Wqq8djmRE1U8eNEHVj?=
 =?iso-8859-2?Q?CowN81oS446dICIAaEuGj0thsSxFbdz1HpOqUk85RhfUoQmC/TSsqNxTdB?=
 =?iso-8859-2?Q?gS/RxPk1PtJG6tgexGe5B7ayMPVza2S0Gd0ec6Ib1vYUm048AwRpP/Neol?=
 =?iso-8859-2?Q?eWf4VMc2pSrCKEtAi+GEmYMNnSjCQM+FoiZp8Ofeg9JD3ICCVlpdr4wFgZ?=
 =?iso-8859-2?Q?hpCJHcwQmPc8WEmgUUCcUlRRzGIiP7l1mdne9AMEDr+JVmw/+L3yCJhMYH?=
 =?iso-8859-2?Q?CK3jybn58ymcr66qLRVRxJsFj4OFr19y31kV8z3oZjjpwEdjLb3epfIKbL?=
 =?iso-8859-2?Q?J7kmoYTYFJNKd0UhnbIA0SCSZZwKwfC/W3SK3TQU+6GoRc4fWl5IfeE7AA?=
 =?iso-8859-2?Q?6wlOrzyWJyBzNvp9VjtK7YOoKcc3o5TCNGrRwx3m7nFIDwYxE1mvby7y/u?=
 =?iso-8859-2?Q?7VRGcy6NZB4B8T9xU2bcTw8UayPgC+rrKrmNv0Z1vatG/byxBp4CgrZxLS?=
 =?iso-8859-2?Q?g33UvX5O4qNAg5ke6WH5FDOeJ/k6vT0HzQqSbtUCBeczUSzK8OzUQ5SCAv?=
 =?iso-8859-2?Q?Q5dtvI1XYKtQPBKk95w/JR7vbjtDnr0lVgPniiIEdqUdq1NN9y7uYfekSB?=
 =?iso-8859-2?Q?ZbPhVzpYGsmKWIZcEMBqTefF71UXAremwGyVQu8/wKmgjUwW/E6aQ0tCYP?=
 =?iso-8859-2?Q?z2GzyFmqgQufiCGxJt/Qrzn8ZlTx/wEXKOub5nAcucu/DHPYOHUCyWVkDM?=
 =?iso-8859-2?Q?1z8HJljTGV81zr8S2H0mrKlCUZqS8bPOEcL0yB3XZj2uqISafoCq1FhkhW?=
 =?iso-8859-2?Q?22Yw2o9d1Xmy/SXGLqt3pkA2/8W2nIJrbcy67cyoBTR0IeLwZ1FF9V1Ilv?=
 =?iso-8859-2?Q?/nYP2uALYMAO+E3YhJsN2mM8I1TbxHcyo2zsbjfs9h1WY5v2Ue8UVBFHiU?=
 =?iso-8859-2?Q?tSdoKntS1hYMIirYum+T+MShy7/LGMs1STsdUwNXT1Vl22OsHL3u78zG3y?=
 =?iso-8859-2?Q?qc9207AmB6U+Xu92DlA4cZlRdnMkkXwcaOEdS5k5XfNbLGopJ86bUHpHTI?=
 =?iso-8859-2?Q?8HVJPnDOkjAYFZApm+4GwzSjPm/ezdM5U1ntY4LJ61zFtKnqFz/C+cei0i?=
 =?iso-8859-2?Q?Rr+VaYDYMehJRWt/UQe/t7iVxfDqdrnmIuR+/BadKJntt+dab97RWI55/M?=
 =?iso-8859-2?Q?6jrGMvay8XlY720ZrEnwbr89yemQwPdO80Z5VmAhqSNjLdU73sanvrtd3T?=
 =?iso-8859-2?Q?OlrLkCBPHkxMEo0Qr0N6Ii3GmyIPW8SRA+jpYx/9uI5aC9wIp7F7HPr44S?=
 =?iso-8859-2?Q?15iCHQ3+esS4MrqhO5QONFkNZiVi7XUd3OaEstYavFyzbOOrA1mHH3Bhuk?=
 =?iso-8859-2?Q?/AKh0x5Iq57+hh38QwIHfJeGm6HiQLKQyZKA9y5rxru9vMDmn4WyIFLA+p?=
 =?iso-8859-2?Q?ctuh5XINFpeN//qaJE09MVqtiNIwu7bX2l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df7f1a98-b3a8-4401-1086-08dd81968079
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 12:09:15.6848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K29ZOhB7bOKakrg+rQdXak8ReAyGxVGryJlhxWRc9t2UD9nKb9vEb9DhBWqPt2vZI75ZyS7jroHswmsxOsSCRaUjOwoiDr/vCNlqqvxvtyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQP153MB1232

> On Wed, Apr 16, 2025 at 08:36:21AM -0700, Shradha Gupta wrote:
> > Currently, the MANA driver allocates pci vector statically based on
> > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases
> > ends up allocating more vectors than it needs.
> > This is because, by this time we do not have a HW channel and do not
> > know how many IRQs should be allocated.
> > To avoid this, we allocate 1 IRQ vector during the creation of HWC and
> > after getting the value supported by hardware, dynamically add the
> > remaining vectors.
> >
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 306 ++++++++++++++----
> >  include/net/mana/gdma.h                       |   5 +-
> >  2 files changed, 250 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 4ffaf7588885..3e3b5854b736 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -6,6 +6,9 @@
> >  #include <linux/pci.h>
> >  #include <linux/utsname.h>
> >  #include <linux/version.h>
> > +#include <linux/msi.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/list.h>
> >
> >  #include <net/mana/mana.h>
> >
> > @@ -80,8 +83,15 @@ static int mana_gd_query_max_resources(struct pci_de=
v
> *pdev)
> >  		return err ? err : -EPROTO;
> >  	}
> >
> > -	if (gc->num_msix_usable > resp.max_msix)
> > -		gc->num_msix_usable =3D resp.max_msix;
> > +	if (!pci_msix_can_alloc_dyn(pdev)) {
> > +		if (gc->num_msix_usable > resp.max_msix)
> > +			gc->num_msix_usable =3D resp.max_msix;
> > +	} else {
> > +		/* If dynamic allocation is enabled we have already allocated
> > +		 * hwc msi
> > +		 */
> > +		gc->num_msix_usable =3D min(resp.max_msix, num_online_cpus()
> + 1);
> > +	}
> >
> >  	if (gc->num_msix_usable <=3D 1)
> >  		return -ENOSPC;
> > @@ -465,9 +475,10 @@ static int mana_gd_register_irq(struct gdma_queue
> *queue,
> >  	struct gdma_irq_context *gic;
> >  	struct gdma_context *gc;
> >  	unsigned int msi_index;
> > -	unsigned long flags;
> > +	struct list_head *pos;
> > +	unsigned long flags, flag_irq;
> >  	struct device *dev;
> > -	int err =3D 0;
> > +	int err =3D 0, count;
> >
> >  	gc =3D gd->gdma_context;
> >  	dev =3D gc->dev;
> > @@ -482,7 +493,22 @@ static int mana_gd_register_irq(struct gdma_queue
> *queue,
> >  	}
> >
> >  	queue->eq.msix_index =3D msi_index;
> > -	gic =3D &gc->irq_contexts[msi_index];
> > +
> > +	/* get the msi_index value from the list*/
> > +	count =3D 0;
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> > +	list_for_each(pos, &gc->irq_contexts) {
> > +		if (count =3D=3D msi_index) {
> > +			gic =3D list_entry(pos, struct gdma_irq_context, gic_list);
> > +			break;
> > +		}
> > +
> > +		count++;
> > +	}
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> > +
> > +	if (!gic)
> > +		return -1;
> >
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_add_rcu(&queue->entry, &gic->eq_list); @@ -497,8 +523,10 @@
> > static void mana_gd_deregiser_irq(struct gdma_queue *queue)
> >  	struct gdma_irq_context *gic;
> >  	struct gdma_context *gc;
> >  	unsigned int msix_index;
> > -	unsigned long flags;
> > +	struct list_head *pos;
> > +	unsigned long flags, flag_irq;
> >  	struct gdma_queue *eq;
> > +	int count;
> >
> >  	gc =3D gd->gdma_context;
> >
> > @@ -507,7 +535,22 @@ static void mana_gd_deregiser_irq(struct
> gdma_queue *queue)
> >  	if (WARN_ON(msix_index >=3D gc->num_msix_usable))
> >  		return;
> >
> > -	gic =3D &gc->irq_contexts[msix_index];
> > +	/* get the msi_index value from the list*/
> > +	count =3D 0;
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> > +	list_for_each(pos, &gc->irq_contexts) {
> > +		if (count =3D=3D msix_index) {
> > +			gic =3D list_entry(pos, struct gdma_irq_context, gic_list);
> > +			break;
> > +		}
> > +
> > +		count++;
> > +	}
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> > +
> > +	if (!gic)
> > +		return;
> > +
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
> >  		if (queue =3D=3D eq) {
> > @@ -1288,11 +1331,11 @@ void mana_gd_free_res_map(struct
> gdma_resource *r)
> >  	r->size =3D 0;
> >  }
> >
> > -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > +int skip_cpu)
> >  {
> >  	const struct cpumask *next, *prev =3D cpu_none_mask;
> >  	cpumask_var_t cpus __free(free_cpumask_var);
> > -	int cpu, weight;
> > +	int cpu, weight, i =3D 0;
> >
> >  	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> >  		return -ENOMEM;
> > @@ -1303,9 +1346,21 @@ static int irq_setup(unsigned int *irqs, unsigne=
d int
> len, int node)
> >  		while (weight > 0) {
> >  			cpumask_andnot(cpus, next, prev);
> >  			for_each_cpu(cpu, cpus) {
> > +				/* If the call is made for irqs which are
> dynamically
> > +				 * added and the num of vcpus is more or equal
> to
> > +				 * allocated msix, we need to skip the first
> > +				 * set of cpus, since they are already affinitized
>=20
> Can you replace the 'set of cpus' with a 'sibling group'?
>=20
> > +				 * to HWC IRQ
> > +				 */
>=20
> This comment should not be here. This is a helper function. User may want=
 to skip
> 1st CPU for whatever reason. Please put the comment in
> mana_gd_setup_dyn_irqs().
>=20
> > +				if (skip_cpu && !i) {
> > +					i =3D 1;
> > +					goto next_cpumask;
> > +				}
>=20
> The 'skip_cpu' variable should be a boolean, and has more a specific name=
. And
> you don't need the local 'i' to implement your logic:
>=20
>         			if (unlikely(skip_first_cpu)) {
>                                         skip_first_cpu =3D false;
>         				goto next_sibling;
>         			}
>=20
> >  				if (len-- =3D=3D 0)
> >  					goto done;
>=20
> This check should go before the one you're adding here.

Hi Yury,
While preparing for the v2 for this patch, I realized that the movement of =
this 'if(len-- =3D=3D 0)' check
above 'if(unlikely(skip_first_cpu))' is not needed as we are deliberately t=
rying to skip 'len--'
in the iteration where skip_first_cpu is true.

Regards,
Shradha=20

>=20
> > +
> >  				irq_set_affinity_and_hint(*irqs++,
> > topology_sibling_cpumask(cpu));
> > +next_cpumask:
> >  				cpumask_andnot(cpus, cpus,
> topology_sibling_cpumask(cpu));
> >  				--weight;
> >  			}
> > @@ -1317,29 +1372,92 @@ static int irq_setup(unsigned int *irqs, unsign=
ed int
> len, int node)
> >  	return 0;
> >  }
> >
> > -static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > +static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> >  {
> >  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> > -	unsigned int max_queues_per_port;
> >  	struct gdma_irq_context *gic;
> > -	unsigned int max_irqs, cpu;
> > -	int start_irq_index =3D 1;
> > -	int nvec, *irqs, irq;
> > +	int *irqs, irq, skip_first_cpu =3D 0;
> > +	unsigned long flags;
> >  	int err, i =3D 0, j;
> >
> >  	cpus_read_lock();
> > -	max_queues_per_port =3D num_online_cpus();
> > -	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > -		max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +	irqs =3D kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> > +		err =3D -ENOMEM;
> > +		goto free_irq_vector;
> > +	}
> >
> > -	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> > -	max_irqs =3D max_queues_per_port + 1;
> > +	for (i =3D 0; i < nvec; i++) {
> > +		gic =3D kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> > +		if (!gic) {
> > +			err =3D -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +		gic->handler =3D mana_gd_process_eq_events;
> > +		INIT_LIST_HEAD(&gic->eq_list);
> > +		spin_lock_init(&gic->lock);
> >
> > -	nvec =3D pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > -	if (nvec < 0) {
> > -		cpus_read_unlock();
> > -		return nvec;
> > +		snprintf(gic->name, MANA_IRQ_NAME_SZ,
> "mana_q%d@pci:%s",
> > +			 i, pci_name(pdev));
> > +
> > +		/* one pci vector is already allocated for HWC */
> > +		irqs[i] =3D pci_irq_vector(pdev, i + 1);
> > +		if (irqs[i] < 0) {
> > +			err =3D irqs[i];
> > +			goto free_current_gic;
> > +		}
> > +
> > +		err =3D request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
> > +		if (err)
> > +			goto free_current_gic;
> > +
> > +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
> > +	}
> > +
> > +	if (gc->num_msix_usable <=3D num_online_cpus())
> > +		skip_first_cpu =3D 1;
> > +
> > +	err =3D irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> > +	if (err)
> > +		goto free_irq;
> > +
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> > +	cpus_read_unlock();
> > +	kfree(irqs);
> > +	return 0;
> > +
> > +free_current_gic:
> > +	kfree(gic);
> > +free_irq:
> > +	for (j =3D i - 1; j >=3D 0; j--) {
> > +		irq =3D pci_irq_vector(pdev, j + 1);
> > +		gic =3D list_last_entry(&gc->irq_contexts, struct gdma_irq_context,
> gic_list);
> > +		irq_update_affinity_hint(irq, NULL);
> > +		free_irq(irq, gic);
> > +		list_del(&gic->gic_list);
> > +		kfree(gic);
> >  	}
> > +	kfree(irqs);
> > +free_irq_vector:
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> > +	cpus_read_unlock();
> > +	return err;
> > +}
> > +
> > +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec) {
> > +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> > +	struct gdma_irq_context *gic;
> > +	int start_irq_index =3D 1;
> > +	unsigned long flags;
> > +	unsigned int cpu;
> > +	int *irqs, irq;
> > +	int err, i =3D 0, j;
> > +
> > +	cpus_read_lock();
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +
> >  	if (nvec <=3D num_online_cpus())
> >  		start_irq_index =3D 0;
> >
> > @@ -1349,15 +1467,12 @@ static int mana_gd_setup_irqs(struct pci_dev
> *pdev)
> >  		goto free_irq_vector;
> >  	}
> >
> > -	gc->irq_contexts =3D kcalloc(nvec, sizeof(struct gdma_irq_context),
> > -				   GFP_KERNEL);
> > -	if (!gc->irq_contexts) {
> > -		err =3D -ENOMEM;
> > -		goto free_irq_array;
> > -	}
> > -
> >  	for (i =3D 0; i < nvec; i++) {
> > -		gic =3D &gc->irq_contexts[i];
> > +		gic =3D kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> > +		if (!gic) {
> > +			err =3D -ENOMEM;
> > +			goto free_irq;
> > +		}
> >  		gic->handler =3D mana_gd_process_eq_events;
> >  		INIT_LIST_HEAD(&gic->eq_list);
> >  		spin_lock_init(&gic->lock);
> > @@ -1372,22 +1487,14 @@ static int mana_gd_setup_irqs(struct pci_dev
> *pdev)
> >  		irq =3D pci_irq_vector(pdev, i);
> >  		if (irq < 0) {
> >  			err =3D irq;
> > -			goto free_irq;
> > +			goto free_current_gic;
> >  		}
> >
> >  		if (!i) {
> >  			err =3D request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> >  			if (err)
> > -				goto free_irq;
> > -
> > -			/* If number of IRQ is one extra than number of online
> CPUs,
> > -			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > -			 * same CPU.
> > -			 * Else we will use different CPUs for IRQ0 and IRQ1.
> > -			 * Also we are using cpumask_local_spread instead of
> > -			 * cpumask_first for the node, because the node can be
> > -			 * mem only.
> > -			 */
> > +				goto free_current_gic;
> > +
> >  			if (start_irq_index) {
> >  				cpu =3D cpumask_local_spread(i, gc-
> >numa_node);
> >  				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> @@ -1399,36
> > +1506,104 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  			err =3D request_irq(irqs[i - start_irq_index], mana_gd_intr,
> 0,
> >  					  gic->name, gic);
> >  			if (err)
> > -				goto free_irq;
> > +				goto free_current_gic;
> >  		}
> > +
> > +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
> >  	}
> >
> > -	err =3D irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> > +	err =3D irq_setup(irqs, nvec - start_irq_index, gc->numa_node, 0);
> >  	if (err)
> >  		goto free_irq;
> >
> > -	gc->max_num_msix =3D nvec;
> > -	gc->num_msix_usable =3D nvec;
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> >  	cpus_read_unlock();
> >  	kfree(irqs);
> >  	return 0;
> >
> > +free_current_gic:
> > +	kfree(gic);
> >  free_irq:
> >  	for (j =3D i - 1; j >=3D 0; j--) {
> >  		irq =3D pci_irq_vector(pdev, j);
> > -		gic =3D &gc->irq_contexts[j];
> > -
> > +		gic =3D list_last_entry(&gc->irq_contexts, struct gdma_irq_context,
> > +gic_list);
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		list_del(&gic->gic_list);
> > +		kfree(gic);
> >  	}
> > -
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts =3D NULL;
> > -free_irq_array:
> >  	kfree(irqs);
> >  free_irq_vector:
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> >  	cpus_read_unlock();
> > -	pci_free_irq_vectors(pdev);
> > +	return err;
> > +}
> > +
> > +static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev) {
> > +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> > +	unsigned int max_irqs, min_irqs;
> > +	int max_queues_per_port;
> > +	int nvec, err;
> > +
> > +	if (pci_msix_can_alloc_dyn(pdev)) {
> > +		max_irqs =3D 1;
> > +		min_irqs =3D 1;
> > +	} else {
> > +		max_queues_per_port =3D num_online_cpus();
> > +		if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > +			max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
> > +		/* Need 1 interrupt for the Hardware communication Channel
> (HWC) */
> > +		max_irqs =3D max_queues_per_port + 1;
> > +		min_irqs =3D 2;
> > +	}
> > +
> > +	nvec =3D pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX=
);
> > +	if (nvec < 0)
> > +		return nvec;
> > +
> > +	err =3D mana_gd_setup_irqs(pdev, nvec);
> > +	if (err) {
> > +		pci_free_irq_vectors(pdev);
> > +		return err;
> > +	}
> > +
> > +	gc->num_msix_usable =3D nvec;
> > +	gc->max_num_msix =3D nvec;
> > +
> > +	return err;
> > +}
> > +
> > +static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev) {
> > +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> > +	int max_irqs, i, err =3D 0;
> > +	struct msi_map irq_map;
> > +
> > +	if (!pci_msix_can_alloc_dyn(pdev))
> > +		/* remain irqs are already allocated with HWC IRQ */
> > +		return 0;
> > +
> > +	/* allocate only remaining IRQs*/
> > +	max_irqs =3D gc->num_msix_usable - 1;
> > +
> > +	for (i =3D 1; i <=3D max_irqs; i++) {
> > +		irq_map =3D pci_msix_alloc_irq_at(pdev, i, NULL);
> > +		if (!irq_map.virq) {
> > +			err =3D irq_map.index;
> > +			/* caller will handle cleaning up all allocated
> > +			 * irqs, after HWC is destroyed
> > +			 */
> > +			return err;
> > +		}
> > +	}
> > +
> > +	err =3D mana_gd_setup_dyn_irqs(pdev, max_irqs);
> > +	if (err)
> > +		return err;
> > +
> > +	gc->max_num_msix =3D gc->max_num_msix + max_irqs;
> > +
> >  	return err;
> >  }
> >
> > @@ -1436,29 +1611,34 @@ static void mana_gd_remove_irqs(struct pci_dev
> > *pdev)  {
> >  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> >  	struct gdma_irq_context *gic;
> > -	int irq, i;
> > +	struct list_head *pos, *n;
> > +	unsigned long flags;
> > +	int irq, i =3D 0;
> >
> >  	if (gc->max_num_msix < 1)
> >  		return;
> >
> > -	for (i =3D 0; i < gc->max_num_msix; i++) {
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +	list_for_each_safe(pos, n, &gc->irq_contexts) {
> >  		irq =3D pci_irq_vector(pdev, i);
> >  		if (irq < 0)
> >  			continue;
> >
> > -		gic =3D &gc->irq_contexts[i];
> > +		gic =3D list_entry(pos, struct gdma_irq_context, gic_list);
> >
> >  		/* Need to clear the hint before free_irq */
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		list_del(pos);
> > +		kfree(gic);
> > +		i++;
> >  	}
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> >
> >  	pci_free_irq_vectors(pdev);
> >
> >  	gc->max_num_msix =3D 0;
> >  	gc->num_msix_usable =3D 0;
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts =3D NULL;
> >  }
> >
> >  static int mana_gd_setup(struct pci_dev *pdev) @@ -1469,9 +1649,9 @@
> > static int mana_gd_setup(struct pci_dev *pdev)
> >  	mana_gd_init_registers(pdev);
> >  	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
> >
> > -	err =3D mana_gd_setup_irqs(pdev);
> > +	err =3D mana_gd_setup_hwc_irqs(pdev);
> >  	if (err) {
> > -		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
> > +		dev_err(gc->dev, "Failed to setup IRQs for HWC creation: %d\n",
> > +err);
> >  		return err;
> >  	}
> >
> > @@ -1487,6 +1667,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
> >  	if (err)
> >  		goto destroy_hwc;
> >
> > +	err =3D mana_gd_setup_remaining_irqs(pdev);
> > +	if (err)
> > +		goto destroy_hwc;
> > +
> >  	err =3D mana_gd_detect_devices(pdev);
> >  	if (err)
> >  		goto destroy_hwc;
> > @@ -1563,6 +1747,8 @@ static int mana_gd_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> >  	gc->is_pf =3D mana_is_pf(pdev->device);
> >  	gc->bar0_va =3D bar0_va;
> >  	gc->dev =3D &pdev->dev;
> > +	INIT_LIST_HEAD(&gc->irq_contexts);
> > +	spin_lock_init(&gc->irq_ctxs_lock);
> >
> >  	if (gc->is_pf)
> >  		gc->mana_pci_debugfs =3D debugfs_create_dir("0",
> mana_debugfs_root);
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> > 228603bf03f2..eae38d7302fe 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> > @@ -363,6 +363,7 @@ struct gdma_irq_context {
> >  	spinlock_t lock;
> >  	struct list_head eq_list;
> >  	char name[MANA_IRQ_NAME_SZ];
> > +	struct list_head gic_list;
> >  };
> >
> >  struct gdma_context {
> > @@ -373,7 +374,9 @@ struct gdma_context {
> >  	unsigned int		max_num_queues;
> >  	unsigned int		max_num_msix;
> >  	unsigned int		num_msix_usable;
> > -	struct gdma_irq_context	*irq_contexts;
> > +	struct list_head	irq_contexts;
> > +	/* Protect the irq_contexts list */
> > +	spinlock_t		irq_ctxs_lock;
> >
> >  	/* L2 MTU */
> >  	u16 adapter_mtu;
> > --
> > 2.34.1

