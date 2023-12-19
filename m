Return-Path: <linux-hyperv+bounces-1357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E72281820A
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 08:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446E91C213BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE608493;
	Tue, 19 Dec 2023 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gR72oiuQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11022011.outbound.protection.outlook.com [52.101.128.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E095C12A;
	Tue, 19 Dec 2023 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzNkWECt65Fq67KZ9z+uIzwza/739YL7nJCMRXL5bgIeIRid3ipDlabQxBbhEqSTpQ3JU/Ezi5I5vxLfB5jmQoy7SQOXedNWeHND02u3H4Fim6w6b3o/l7fOxfJpG1tG6p8z7ovuZWF1Q8/323Pns/gN8ODRVR9j7I8J0P913N3QCROOt/SV2uFZTnhncmDwZWn0Cgnmvm/tYY3hYuQKoZNmnJubUQflINQBukZ8j0BUkwLl0LfcqxSoOHWJ7S98guxxAAjczshHi8mOALc7bRI00Xkkk8gQ9uP7Rity1hY4L0dlBjIQt06Nr8hAYZsmmEht6X7qC7263M99s6rsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu1EaTFg+YulzPjjqtF1gfO5wZwyUV7N4KY8/EOUQVA=;
 b=Y5dM8pRFyXdBqcCGedMcQyaQAqmjnNKtu0T3ZecIqFzzmpQzbcem8OCYO7YwdCATxOgTPEbPZqhSwMBz/+qQhevbZG2s1gcJ4aAK2WD1/HMbiHhudn9vErWoF/zFpAZ6yZAWNpZUb3x1QncaK1o2u0c1kLLbtrku31ag35MKkw/grKIe25m64LZOnOcjMpBqqlWRBTlYu2/eSKMQJdDgOGCN5tI1BnT/mjgoFAMqeY0AtCBE1YjIds5lzeiq0QLgg8hzx/6EMosObwEgnxmIxwM/xIsunyubLviYoMtdxc2NqOo9mpZNGXDffrVuvZeOhlsQY9UJX9aTNKJCbyR3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu1EaTFg+YulzPjjqtF1gfO5wZwyUV7N4KY8/EOUQVA=;
 b=gR72oiuQgIcpCT8//I4obgwHT6D9IVBa7WXRixK9yQee8x2638o3CL0jtOlyBXemwnInUN4BMn+uYRMJuCHwEIpvNJVxPCOqOa5mcEqpile4bmZMb860fHaD7GHpSfqVBsAgAz/Nt6IIha9hQtUytYmQ2/+oS3FPnRj4sa/rm38=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by TYZP153MB0413.APCP153.PROD.OUTLOOK.COM (2603:1096:400:2e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.5; Tue, 19 Dec
 2023 07:14:33 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7135.004; Tue, 19 Dec 2023
 07:14:33 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Yury Norov <yury.norov@gmail.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs
 per CPUs
Thread-Topic: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index: AQHaMTCKhnR8tJj+p0KJn4+4XMR1UbCwMyDQ
Date: Tue, 19 Dec 2023 07:14:32 +0000
Message-ID:
 <PUZP153MB0788C75BDE241EDF4CDFFC13CC97A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
 <20231217213214.1905481-4-yury.norov@gmail.com>
In-Reply-To: <20231217213214.1905481-4-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b5c28ec4-2412-4a77-99f4-bfc7d66a9ec6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-19T07:12:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|TYZP153MB0413:EE_
x-ms-office365-filtering-correlation-id: 8fa080c8-5c38-4266-1020-08dc00622665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lPNTqleJjcYEpV79z/93UvwHDdTgvR+Ej8W74wnosbbIZyA7fza4RPUwESr5hur4StR37fBBCgyMB1TiNrLc5U/2DxQQMMnRgvyAssWHVyUITYMjcfp98n30pfyC90pu0iRgU3lKzycUa3utL+dDpmrmaluF4eSaKFZ9erA8W5/m7DEx9Oam1LBIs7Dn5BmeYHI3IVqNxkGp46dv12ImAgoT7Wkffh8D3mxOwKDKkGjJ5w7lmiw7rhc/jZmhv9Jo99L1UfO6VuScOm5nGrO+y8P3c2HA7KDYWaJEMPKhNQgClZO0oFq0puH2vZYvDQWpO3bRNAh8eyAn3O9HcuPq9cXUxCN5HwLMA5h2AT87iFYr8hqsZjAkNaQfpnmlw2vOEPETBidDvh4x0fdv11LqWdQ8awFWyJiLz9qViL5LiC1KMjwlagl1Hm6wsOd2nNvWdX6bx8dLzkJuI40lvv/NlLldzD0I2yfebSaGQJQUbgxgWONLyb/zIYkNJ8fgyCBE73/ng2D+5dtUuccwwWcsECk5c3WmWulQLR+sSvdgEE6FvqcbgPjNgSZNy+/wXFroNNkLDjtCL52Ly3oT6SnnyGThXo+CPK8z1v9NlEuj5q9VlautcHBM9a0QFGdjSguPlyOAIZ80QU94H4nrTso16fk/iLhUzTwD9d1hAtuJVAMtU0lECSSDAThBoFyjkcWgZ+eGshyNPww27snHHuUGoQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(107886003)(26005)(71200400001)(921008)(9686003)(6506007)(7696005)(38070700009)(41300700001)(10290500003)(478600001)(33656002)(55016003)(86362001)(82950400001)(82960400001)(38100700002)(122000001)(316002)(52536014)(8676002)(8936002)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(110136005)(4326008)(2906002)(5660300002)(7416002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1UyxpjBH8UVwcFY4vGOYrfrk1+3GXIfMQlxSVl3PxxjU+7oTxMiZ104JfgS0?=
 =?us-ascii?Q?aOxzUeDDPh9J/67uoYfpHj/YTygIPlPTb4nO4f3y8cs+idzUOJWpvKyMtwrj?=
 =?us-ascii?Q?xM7BxBGxoXHvhOndvmaoAPEnpMAH2/hhiQiX+9i+2uyA8YJB+rJZcjlYeoHi?=
 =?us-ascii?Q?wHx4xJZWE53mFDuEBMv1qbVUuloZ3TQaaWsnc866gkO/mzfn40NEACVtlNRV?=
 =?us-ascii?Q?E97Eo/ixypEmKHrW0xkGXYh46JvsoerK4EbC1AKpaCW+Lk8Ff18/rUviPihd?=
 =?us-ascii?Q?jirkKWADQDkJCwD8qB1DLXjFW8k7yukqqnjeD8tfVTREmrNSFg+dmcpIC/Fj?=
 =?us-ascii?Q?TvfTQkKQmBW82dUuYeRVUiLIaq981KwAdY0wdG5Vu89LeNrcXYSAUed6lKvq?=
 =?us-ascii?Q?UyxZdh0bd66wQyL2NuZnL9bdWpvktx6aYLNhi9DcqR4n/RJ+IXyyaHZI4S5m?=
 =?us-ascii?Q?6VLLPD/Ly5SxfWG/CqkYocsUL3Hf3Na8Q77cdKCb2w64c28D/Lw+1V9lAaYH?=
 =?us-ascii?Q?e8HJV1enRsNlHsIUsFHgu60X+cQRmautTyqd0od2EwB+wUTf3l7yNa8Dkg6E?=
 =?us-ascii?Q?V6ja0mNrI9bkt7qMQ3BY/lmAZv+ruZQgBH46ion7mdSO/ybQ0jWVWOLWJF7M?=
 =?us-ascii?Q?0RfIqsO+TEnjJJlwENHf2dbPqMv+cm/G1ZB77YTApY/46BtIdzIjEgmTfCpf?=
 =?us-ascii?Q?G+Pvp9PosRRahj0U7G8Z55Oqwjp3FkjZIC96xURRm67y6S2xqBDSnmWio7Vh?=
 =?us-ascii?Q?5cjIIg+witMDY9QQc+qZbl/OrHP89uQz3Y1gRjhpgh18bJngZlRLhumAvc2P?=
 =?us-ascii?Q?xuPtnXbtVR7A5EZfj3Dg4x8MkzNr0l1UE4y4TOn2zPYHn4RdjSDGqHeCqGh3?=
 =?us-ascii?Q?vI46MVKgTBQhLCxFB9HrILxgdJatl0WSzTr9OHMIn6qRlhx3piGn7Ba3mkDP?=
 =?us-ascii?Q?sNDFgoLrvK9svSz0SQMC+sO4ihj+gQE9VvrT+5sdzKh8Sg43wTwXmnjTf4BN?=
 =?us-ascii?Q?bmXg7pCYpQqTIbny8o94XsMIIV63q83KoMlUua/k/YNcmU/ljNj6fyQ6kXAm?=
 =?us-ascii?Q?MTF5ZwXk6HCIz0+0QL17QCPnYOq0sDLEKh7Q9wJyoVr7z3YBhQQ4ZjgchzLb?=
 =?us-ascii?Q?kNn4NpzSL8hvGbP46G5gVNO6qsoR/zgrxP+wCC4Ci92mEVCj1Ut5cUItfaVc?=
 =?us-ascii?Q?XB5ltSqJxw4eWcFs9NNYkM6CwGJS9vI4LZUMyzN2wjmt+1DvkJlC33GTf8x3?=
 =?us-ascii?Q?EIKyciLCufK6Z/MkSK14g5UAjN1CuZc5Wk5DcP/zMhmUpfhMdnAsdDc+M9VV?=
 =?us-ascii?Q?ZkDnuRoaGswbxd/D8Gc4xNI+o6OsVwmYgJQiKu6zCm4DJCWoH6Z9UDxDVbf5?=
 =?us-ascii?Q?ZWfq3AAa5/veYvjKNk/3G61TxEe+1btaWFSPVUMloGQQa07Y5lNjR7B6Pevt?=
 =?us-ascii?Q?EmlbXHguZwBeuU+q5cFJPPaZOYACTMgfazcgPOfZoryoIU6Ynt0SraebS5Y3?=
 =?us-ascii?Q?skuwCX7XDRSXNGObN3A8Z2GyZJ3Xe3891kCX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa080c8-5c38-4266-1020-08dc00622665
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 07:14:33.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sM6YDgbgSsmilMbGS39FR1NFduJKSiz9yuKqhOEdBnGhJ4p+P016D1Igr7mHI1Qh6XiKhQHsPqtgxLaSER2E0+nxwXRjZ34gtJPPH75RDRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0413



>-----Original Message-----
>From: Yury Norov <yury.norov@gmail.com>
>Sent: Monday, December 18, 2023 3:02 AM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivasa=
n
><kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
>wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
><longli@microsoft.com>; yury.norov@gmail.com; leon@kernel.org;
>cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
>tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; =
linux-
>kernel@vger.kernel.org; linux-rdma@vger.kernel.org
>Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
><paulros@microsoft.com>
>Subject: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs p=
er
>CPUs
>
>[Some people who received this message don't often get email from
>yury.norov@gmail.com. Learn why this is important at
>https://aka.ms/LearnAboutSenderIdentification ]
>
>Souradeep investigated that the driver performs faster if IRQs are spread =
on CPUs
>with the following heuristics:
>
>1. No more than one IRQ per CPU, if possible; 2. NUMA locality is the seco=
nd
>priority; 3. Sibling dislocality is the last priority.
>
>Let's consider this topology:
>
>Node            0               1
>Core        0       1       2       3
>CPU       0   1   2   3   4   5   6   7
>
>The most performant IRQ distribution based on the above topology and heuri=
stics
>may look like this:
>
>IRQ     Nodes   Cores   CPUs
>0       1       0       0-1
>1       1       1       2-3
>2       1       0       0-1
>3       1       1       2-3
>4       2       2       4-5
>5       2       3       6-7
>6       2       2       4-5
>7       2       3       6-7
>
>The irq_setup() routine introduced in this patch leverages the
>for_each_numa_hop_mask() iterator and assigns IRQs to sibling groups as
>described above.
>
>According to [1], for NUMA-aware but sibling-ignorant IRQ distribution bas=
ed on
>cpumask_local_spread() performance test results look like this:
>
>./ntttcp -r -m 16
>NTTTCP for Linux 1.4.0
>---------------------------------------------------------
>08:05:20 INFO: 17 threads created
>08:05:28 INFO: Network activity progressing...
>08:06:28 INFO: Test run completed.
>08:06:28 INFO: Test cycle finished.
>08:06:28 INFO: #####  Totals:  #####
>08:06:28 INFO: test duration    :60.00 seconds
>08:06:28 INFO: total bytes      :630292053310
>08:06:28 INFO:   throughput     :84.04Gbps
>08:06:28 INFO:   retrans segs   :4
>08:06:28 INFO: cpu cores        :192
>08:06:28 INFO:   cpu speed      :3799.725MHz
>08:06:28 INFO:   user           :0.05%
>08:06:28 INFO:   system         :1.60%
>08:06:28 INFO:   idle           :96.41%
>08:06:28 INFO:   iowait         :0.00%
>08:06:28 INFO:   softirq        :1.94%
>08:06:28 INFO:   cycles/byte    :2.50
>08:06:28 INFO: cpu busy (all)   :534.41%
>
>For NUMA- and sibling-aware IRQ distribution, the same test works 15% fast=
er:
>
>./ntttcp -r -m 16
>NTTTCP for Linux 1.4.0
>---------------------------------------------------------
>08:08:51 INFO: 17 threads created
>08:08:56 INFO: Network activity progressing...
>08:09:56 INFO: Test run completed.
>08:09:56 INFO: Test cycle finished.
>08:09:56 INFO: #####  Totals:  #####
>08:09:56 INFO: test duration    :60.00 seconds
>08:09:56 INFO: total bytes      :741966608384
>08:09:56 INFO:   throughput     :98.93Gbps
>08:09:56 INFO:   retrans segs   :6
>08:09:56 INFO: cpu cores        :192
>08:09:56 INFO:   cpu speed      :3799.791MHz
>08:09:56 INFO:   user           :0.06%
>08:09:56 INFO:   system         :1.81%
>08:09:56 INFO:   idle           :96.18%
>08:09:56 INFO:   iowait         :0.00%
>08:09:56 INFO:   softirq        :1.95%
>08:09:56 INFO:   cycles/byte    :2.25
>08:09:56 INFO: cpu busy (all)   :569.22%
>
>[1]
>https://lore.kernel/
>.org%2Fall%2F20231211063726.GA4977%40linuxonhyperv3.guj3yctzbm1etfxqx2v
>ob5hsef.xx.internal.cloudapp.net%2F&data=3D05%7C02%7Cschakrabarti%40micros
>oft.com%7Ca385a5a5d661458219c208dbff47a7ab%7C72f988bf86f141af91ab2d7
>cd011db47%7C1%7C0%7C638384455520036393%7CUnknown%7CTWFpbGZsb3d
>8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
>7C3000%7C%7C%7C&sdata=3DkzoalzSu6frB0GIaUM5VWsz04%2FsB%2FBdXwXKb26
>IhqkE%3D&reserved=3D0
>
>Signed-off-by: Yury Norov <yury.norov@gmail.com>
>Co-developed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Please also add Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.mi=
crosoft.com>
>---
> .../net/ethernet/microsoft/mana/gdma_main.c   | 28 +++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>index 6367de0c2c2e..11e64e42e3b2 100644
>--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>@@ -1243,6 +1243,34 @@ void mana_gd_free_res_map(struct gdma_resource
>*r)
>        r->size =3D 0;
> }
>
>+static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int
>+len, int node) {
>+       const struct cpumask *next, *prev =3D cpu_none_mask;
>+       cpumask_var_t cpus __free(free_cpumask_var);
>+       int cpu, weight;
>+
>+       if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
>+               return -ENOMEM;
>+
>+       rcu_read_lock();
>+       for_each_numa_hop_mask(next, node) {
>+               weight =3D cpumask_weight_andnot(next, prev);
>+               while (weight-- > 0) {
>+                       cpumask_andnot(cpus, next, prev);
>+                       for_each_cpu(cpu, cpus) {
>+                               if (len-- =3D=3D 0)
>+                                       goto done;
>+                               irq_set_affinity_and_hint(*irqs++,
>topology_sibling_cpumask(cpu));
>+                               cpumask_andnot(cpus, cpus, topology_siblin=
g_cpumask(cpu));
>+                       }
>+               }
>+               prev =3D next;
>+       }
>+done:
>+       rcu_read_unlock();
>+       return 0;
>+}
>+
> static int mana_gd_setup_irqs(struct pci_dev *pdev)  {
>        unsigned int max_queues_per_port =3D num_online_cpus();
>--
>2.40.1


