Return-Path: <linux-hyperv+bounces-1056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70607F9CC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 10:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EE28125F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13116433;
	Mon, 27 Nov 2023 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KPYpr/ER"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2D12D;
	Mon, 27 Nov 2023 01:37:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LohO1OY8ofD7vU6VNYovbvtWEjpYo3ZP7ntvhAcldst/ntVMUc8QMe9bPUw5lYXRw//y39gN2UOp4jhC6qt2GejM0bgcjPNtOwl/PO0YUGnBnbfZcyU7wNy8gjmRz4f6BfdmazeVOjIVsV6oTLqSFuwcIlYtulkBQVVsu3sx7WWMKiK3e7W6iqHhBLfPPiIq9j5sVdUfM9TD+2bpSjE1gMYUZQGCUCLnGhlxcjHiZQvbG2HaxfrhGPjdK4oOD5+Tfk8HbQ5tmEOF6iXVyN5HbYCYzt/o2XdYbf2sMBpS1PDPlINevhN/6Ui31c+cjx+WgVgea+FVxttdvn+Wo9A6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf5D/6r+NXC7ziXzfOuUKnI5OAASYMDQ9PCJ9kx0Ohk=;
 b=l95ullQ6rSV0+BrAGrqZtTaL8HcQ5egN2L+A5RSuAvp4A8J0nCRDG1s7362AGFtFfKhoiG0hbzA2Ewvm5gQSlTFCc/WMMEh890+xrCwU23x6Mi7SzN+6Gc+1cRiP1RKYqIp+YwPh4q9pW0Or+4G2caOKxyFliQf5MgIN4FgyGEZknPasWj+viUTt6WV8ciMA9yG6/Imle2Ph3f4/F0STHV1fiS5ow2Un2UaeEE7dYxOTF//qZ7S0852OWn8pcv0oIOzi1+RYocU1vj6Ti76svtssc+yVQiAnxz4Ax4bGXa0VCP+enEnAMc8gJA+KkmZQDENSdUkt1j6nyez3rqhuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf5D/6r+NXC7ziXzfOuUKnI5OAASYMDQ9PCJ9kx0Ohk=;
 b=KPYpr/ERACMNnQNB1eLTK+nYsQkpIGLIHoeIMPrKQntEVE/2CYFHAdEiTaBSw5v5QSFNF3rHxex7FOV4f5mP3USAX3nF+RfJctm+REGx7N1zXafyYaXYjPN4MRP1g5hXTrECqI8YfF2Hf+P3W45s7RH6D6AqFi6hZNlaHi+KjqM=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SEYP153MB0976.APCP153.PROD.OUTLOOK.COM (2603:1096:101:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.5; Mon, 27 Nov
 2023 09:36:39 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7068.002; Mon, 27 Nov 2023
 09:36:38 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Thread-Topic: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Thread-Index: AQHaHIJKVWtqOkYgZ0uGtD+z/VnogLCFcX6AgAh9zEA=
Date: Mon, 27 Nov 2023 09:36:38 +0000
Message-ID:
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References:
 <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
In-Reply-To: <20231121154841.7fc019c8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=face184a-dcef-4d2d-9024-da46c997f307;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-27T09:29:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SEYP153MB0976:EE_
x-ms-office365-filtering-correlation-id: a7deb21d-9a94-40a2-bc37-08dbef2c5ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uyyw2hHQuQLWqg9LNjczsGCQFC0TPdhSlChDAs46kriyq4xN1+QN23N6hKYsEB4wNJ8Z0orc6sCR91FTcedtFLeWWhWzrpHfvdwhcEhubaNMXGsbFyoyHKi8IwR5fXAV9pv4z3xzRHDK0ZMsbK7qOWelSCZyqib09pDNYS6T2MZFeEGZ/0C3xW0Ah5Lvo0Tm8ik2EKLUHSAnIJt3fqmKEmfMQOz6vbjlsPJDVe4O6PkgrOlRAQNxe97hD57a4j0rjUv+0XfV7X4zQudMJFac7Alkc8gnhfF/IyMy1tSgPY90CcrubXZOhs7+JlTCI7maaejSivkSdoJ0tK0Nbewxjpl2XsyJyDiB1KCl3E1Tdh5gAhDCMZl0q73Yn+DkkSwxQy5L8DLJiNqU4+Vez3MTrsJTHXbHco0bMlITlks1FdWMzzq2KuFHgAjujGv4tdMGOhrYwkLGxgTSKh9qOjxRYbrldRy8yc5yaPxcEJkUxGIbUx3EA16zPfxVDH5GjeAvnjJTYcBmZWxz3O0TEpCSPvdDZY+x6U1jRa10OWk4UrpAd/Iml5Lbz6zpym3KJaoeTWjXpTJA90IGCqzy9OGDDevpE6r4EvAir0ljXFICkq0X+cICHjeJqTJxct9wFebx5x3PNV1FpKKTz1qDPy5PzNBxZxlqkpZdzRE5/ArytXmTWBgVAyPIhU3JSeZVKibBXRo2PPndFD1tMXcKYdMvJg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(4326008)(52536014)(5660300002)(41300700001)(8990500004)(7416002)(26005)(8936002)(8676002)(2906002)(55016003)(10290500003)(478600001)(71200400001)(7696005)(6506007)(9686003)(107886003)(83380400001)(38100700002)(66946007)(316002)(76116006)(66446008)(66476007)(66556008)(64756008)(54906003)(110136005)(122000001)(82950400001)(82960400001)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4fjGuBdHrW0zIjFHqi33QLEz4cHTbKMvXp7AdeQ9rJO8mF362iAwMpt3r/6V?=
 =?us-ascii?Q?KAr3A2fIr9SS82+oNCG9oSDIjhvVpFsVoVCJKy9ulh3lxrv/83sq0AndN14a?=
 =?us-ascii?Q?NTcyAinKW8gwx+5hCVQRHiwVKQ1lcTGe1Txx7XUU0AT4TnUd184sk8zMYB4s?=
 =?us-ascii?Q?pASgCFvRys+j/IX/oCAAt1R8zeFtGNf6NEy92NYKXafysxVrsd8U9+tdVkHz?=
 =?us-ascii?Q?PM2SPt/riEsHniW4FRd/8NpOczPkFts33MWo3J5v5pw2w2IXwsA0fVbTrJb8?=
 =?us-ascii?Q?1+dORMtWotYd8XPhqmSf9GJjJ9UzeZke8/yUG1jimeA7JjUc/8Pnf5DFLSio?=
 =?us-ascii?Q?N6HqOmn2iHSt8BTw5IbdCs9DLbB0P+pxoy/6BS89mpGWST5EuML5qNcdIogt?=
 =?us-ascii?Q?O1lT2qd9k/D5W8kmKZSYpt5effK9RbExqFF9Maqtye8PZpjtpF84uuITOVv3?=
 =?us-ascii?Q?bpSOrdgn0PMFYVQzJIIIZ0KblaofQuymLPi8+MJoCkoFPtTqLNUAlOeZM1dF?=
 =?us-ascii?Q?2uQdNCH2/vJv8thAs3r+2DH8nguSuCu88kEXhjx5hnDaVFh3iCKf80kbkDBu?=
 =?us-ascii?Q?H1Z1pGjjAw5qmcn4xY8J3p9KGeFh9ZkAXNpHO2Cd6IWr4nZaIsaUR21h+erA?=
 =?us-ascii?Q?/67UbXOtDeIwYIkX1dJOZeW+FOHmdbIuUvYd05DlwY/3hUmVbk9T2aK7Wv2u?=
 =?us-ascii?Q?Qc3YG5WXBUplQWcQIyi6Er1LPWGA8DrV85BUz2BxhHqmqJTwefKRv7LLCXC9?=
 =?us-ascii?Q?DiK93BFLJ3Fc7cHfR5SXoxoFI4sxSpk4G23kXcYdZVOcrK+61DoNB9I18MkZ?=
 =?us-ascii?Q?ehSpdHKJhK5gpd2Lj/At1nLUw8gu0EHk9pD3VC0QlOr10QRigMkxLzJ/L+L7?=
 =?us-ascii?Q?7EyN+Sh4qZFrHw1gZKpvf3Ft1+N6Eo424dyUlSAkz4+Cg0jAZjzVcXeILmgp?=
 =?us-ascii?Q?7Vc1xLXCvJkJWi9ZgEZkbyYAwKPwtL7OLTSBYkV7s1wHPYmyvrINM+sNKspB?=
 =?us-ascii?Q?7xPy4p4NxU3mJIu+TQGzscj9p5xkvB+2dj5zNCFnMGtSLXBj50YQLRpd5faT?=
 =?us-ascii?Q?kAtoGDjHd61b316gT3cxml6nKWyFXP7RETsyYyyDlQylEq11UhIltNAHQpbF?=
 =?us-ascii?Q?VGUVxKRUml4OgnOgQMyRzDmkNbQDwYngGNkVSWCEZQ6Qr+Qw6dY6kND3/ml0?=
 =?us-ascii?Q?qt9jNBTcpYDzfwXvz4r4wD4pNRlXsI+i2VlF7aT4vfgWb0PdJB8dsreaXrAu?=
 =?us-ascii?Q?ChXizThgANi+MqNCuRi4L4Oq2WBT1SpndHg6UbZj0i4wdF1DQIdo9PAKoMAQ?=
 =?us-ascii?Q?u9Ez9W6UVAJ9iwR5N7EXnEDbmfM3enEPYt9d3RxnzOSyNmYFuWhIrcar7t7d?=
 =?us-ascii?Q?bz7cw+caLnXKOlCfXnXug3Ua87mQcukL6D1T0B5G/2VrEDs/J9cJqvD53X3x?=
 =?us-ascii?Q?eu0BB9+WieT84Vwt0bSXH1a6d9gga4ksRhYRTkMn0AvPFzGGwQ+tfTVbsD3b?=
 =?us-ascii?Q?Comhio9G1MvXNVnbEHylHyEaX/aR0nDyc5L+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7deb21d-9a94-40a2-bc37-08dbef2c5ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 09:36:38.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehEa9d60wgnPQRWtjyXD2pYPu466U1/I+o3dKKhbsnz6zhFKozyUkkiektS7QmEK/42Q5dMJ4/jg6eiXdQVDjKzQq1d9/6SSc7eRCaPZXI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYP153MB0976



>-----Original Message-----
>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, November 22, 2023 5:19 AM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>pabeni@redhat.com; Long Li <longli@microsoft.com>;
>sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linu=
x-
>hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg;
>linux-rdma@vger.kernel.org; Souradeep Chakrabarti
><schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
>Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affin=
ity on
>HT cores
>
>On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
>> Existing MANA design assigns IRQ to every CPUs, including sibling
>> hyper-threads in a core. This causes multiple IRQs to work on same CPU
>> and may reduce the network performance with RSS.
>>
>> Improve the performance by adhering the configuration for RSS, which
>> assigns IRQ on HT cores.
>
>Drivers should not have to carry 120 LoC for something as basic as spreadi=
ng IRQs.
>Please take a look at include/linux/topology.h and if there's nothing that=
 fits your
>needs there - add it. That way other drivers can reuse it.
Because of the current design idea, it is easier to keep things inside
the mana driver code here. As the idea of IRQ distribution here is :
1)Loop through interrupts to assign CPU
2)Find non sibling online CPU from local NUMA and assign the IRQs
on them.
3)If number of IRQs is more than number of non-sibling CPU in that
NUMA node, then assign on sibling CPU of that node.
4)Keep doing it till all the online CPUs are used or no more IRQs.
5)If all CPUs in that node are used, goto next NUMA node with CPU.
Keep doing 2 and 3.
6) If all CPUs in all NUMA nodes are used, but still there are IRQs
then wrap over from first local NUMA node and continue
doing 2, 3 4 till all IRQs are assigned.

