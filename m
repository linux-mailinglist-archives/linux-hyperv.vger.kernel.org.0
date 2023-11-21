Return-Path: <linux-hyperv+bounces-1004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A97F3502
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEB0282614
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530C5B204;
	Tue, 21 Nov 2023 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aJ2WddP9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021007.outbound.protection.outlook.com [52.101.61.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7AF4;
	Tue, 21 Nov 2023 09:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOZuMKJ6zhYJNLK4NV30tRfD9se1cAH32EYRzgLdtjNriXduOlylm1pRx3eJ7Lx9j5hZJ0d6QzjyYPnIu2JnXnWgnZdhZQnJdFYI4FW14q68lQcSgzqI/JV5FKM1eosOUflgZprIPuz8XRmuYctm/8pp8iv/Urhp5Pcjw/s8C5Ik92I4vxAhKrzKCaWffYjyh5/sgjCUishvwvhVFINlrJkwkvXFR3jzkS4ebaDiucQFNOcIOgcSsnkzyi6bY974oywu3MLJhxE+1VV7agwuIdrTgOwlfFgmAdju0j5i+mCDQFmlQUVzH5LU8cA0wUO/2OjvJDLJsYGNKYEcIVrtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDxGDSkABDtFNCvCyalGFN37vFCi6rYC/NoTPcpLf0s=;
 b=FyFiyY9yIvJHFwfFEWLTI9hcyyUKLyATRgIAuo94qZaC+c7XUOsX0mcYrEQQA7uFoZX11NMauhTcvMtUx7aHlFkAGz9k6rJCFLp+T13MwXVsOYir1fskP1DgRJfBuDUwqeibTCa30i2iqIbywVqtuHCibrTG9dmAebe42kPcWmLArOfkHajjmaiVb+Om18gKmpWGcLMRnw67dg7hiKxDAIAwa+0SVPtxlLozRxPOGv2ZgL4P4U/HAAmDuRN1OpH94fclflYOWIPIK4oLG0YFcm3XWiisR451GGRN6PhWruTn6YxnqIZCsJbT7K/o6vJQ/9fZRNyBr6qC1kAaiOQT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDxGDSkABDtFNCvCyalGFN37vFCi6rYC/NoTPcpLf0s=;
 b=aJ2WddP9xzuy3oDtN4s4u/ZIawn6ydMEALhLKjJBWhOr6L8idtCg9D7okGD4ROuNoPRJIe63kHUipGhZorBUb+WB79sjnroLDCztNMILR4FRqzUtVCk65HwGZSWhglA2vVLXi52AwUasaT+vTbVTjM9MzmeS6OLSB3Kf5GdZSj0=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DS7PR21MB3452.namprd21.prod.outlook.com (2603:10b6:8:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.10; Tue, 21 Nov
 2023 17:37:12 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::31b:6110:928d:142f]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::31b:6110:928d:142f%3]) with mapi id 15.20.7046.009; Tue, 21 Nov 2023
 17:37:12 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Topic: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Thread-Index: AQHaHIJJ65cwMLSQwUeLvFL6eERdgLCFAMfw
Date: Tue, 21 Nov 2023 17:37:11 +0000
Message-ID:
 <PH7PR21MB3116043F0A93BD5AD23C6C91CABBA@PH7PR21MB3116.namprd21.prod.outlook.com>
References:
 <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1dcdd3b6-59dd-4223-888c-d8cc864ebd65;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-21T17:05:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DS7PR21MB3452:EE_
x-ms-office365-filtering-correlation-id: 51f2c3a4-2514-42ca-c621-08dbeab87e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EudmCOQDh6RMbvKclpqyWmkSHwIaTxnXS6glhmuuM344d+lEdhfFvYOZUKpW+PihktksU5dLjOEwCHE6tqz6SFY5WGzY7RID/PHI9o1acIg9R4o7Crz15aZelSOmOVIgL5TCHkxjMCLnW84MC8AVOTmhP4zYX6sWvTQWGA8gUgmqbkD4GqUMpm/NvDqJZ+UbMwKcbKmXhL8JR6sQg4VUGG9zoYCVJEWInfbivP5EUr/nuwud0ewaSoqNAdXHvXETKWuRtcvxXkKI4rfL0XBeS5/vp/P4XoBbIc78b6RBnhYRb01V5sTQGZ38FZHbSQf9mWmeMrKzG50w42nK1unelc+MhVRO9j0X4sIWOjgauNExXxybc0n0jbJLrdH759zJjegYsp7bQy8ndxtpvifXAvCdx4ajeV6tD8sjwYYv5XrzDQbjqLoqQZHpMx8/L/Z6WhC/Y4eMU/Q53bOkNv74Spr+Ws9y6Vl7TZQUVQdQtEID73ZdCscYteX2YOGuNO8BlRWRn7yoq7ccA67+uHb5kuRlysG0eulICGfrbnGeU1Knyer/Y4dNU1HDHm1/+YNNoIRQB4lAOj12j2rJOHlrgTeAvaeqYSguRypxmZsDnDiT0wXJMtDBpaAFONalY07MOXeGtFnn9Kgwzvsv5oYPFX7qb0n2XR9HVpuri7e3IqhkHlxAtj1XXm/GTL2+19yk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(9686003)(107886003)(26005)(41300700001)(52536014)(8936002)(4326008)(8676002)(38100700002)(7416002)(2906002)(10290500003)(5660300002)(478600001)(54906003)(6506007)(7696005)(66946007)(71200400001)(8990500004)(110136005)(316002)(64756008)(66446008)(66476007)(66556008)(76116006)(33656002)(921008)(122000001)(86362001)(82950400001)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KkaASjGdX3BOrKcDGwA3jgdKZ9YouoqyWOfKEyRsiFYqEAwtR/clUwQ56TCg?=
 =?us-ascii?Q?boPloNi8pgBN/sL7xLTlqWXl/bfPkQCcqdmFiK4KEgGSm5rMxmDCWZ1UUcWc?=
 =?us-ascii?Q?j0LozWBuGDaYofKREFWUI3d7OBJbJ1HzpveDDiVkAbwQhk9fdPSvgkfnOYyr?=
 =?us-ascii?Q?9TZd8kq3GWc5RUCCFh990d5Zc51qFNkhnBdm2YtavQL9Vj20ZBllkq7k7qfC?=
 =?us-ascii?Q?Fnz38sFQhPAxhKa+LrRCUaBF+hkBPNr0KO8VafoOvNj8k7vj5n+BYt3h309L?=
 =?us-ascii?Q?mUPLQYtvI/oDrYwyCCvDsA+EtbR1lOdiXLeQE9ZUDA5f/VLaAh9BPZ9RTyO9?=
 =?us-ascii?Q?cKrZd5irdzyle9Y9xpvDQuick+27l6kLuTZ/iwe5AarM/8N36CbgYFlaoIsS?=
 =?us-ascii?Q?fsgugehMCEab5w5VAz3Z1wwPsfa1FUJZC2/Ile9dVIvoTxLh1/O8jxZ+CYNm?=
 =?us-ascii?Q?j7X93KkBMeYZpdvzYmbJH/jC13Xmw1ZL4KrQxyNBJ7oO0M4qQb2PuSQ7Xios?=
 =?us-ascii?Q?AhVwDzXBB0kxjSAjhiHZ7cYUDoBcx03T2Lwrh87zv9PSFJZIKp196l1z3O+e?=
 =?us-ascii?Q?6FLtDx3w0CmW45ViaY3rcPVAR4OefoDvHdGmlaVILchETgtmA3cwUpbSUQym?=
 =?us-ascii?Q?ae/UaT1c9FuCN1yhvtRqrtgq7CrauTpl1LnpjOs34cGKsIh/b7/DR++vstQq?=
 =?us-ascii?Q?FkUK9MrSga31+qW7qH0jaNu189QrP9MWJAcWZioy4UW6emNm4GGBkUQvVgBS?=
 =?us-ascii?Q?X2Yq9exxq8mbJS0M6AT+N5jp7zIGhd4GniMqUEkaLgb4YRxhfXgub/CQ9ES8?=
 =?us-ascii?Q?2OiZYGRge7+03CSm8wUG47yho/DicW3kgGyUm9hmfjEiocgnt1tUX9+kC7fG?=
 =?us-ascii?Q?ZQHiIwSCFIJewmhgF44yO/Y6bK0VBRmTnR715JFIWUKh1vKftJMq0tS/ujKB?=
 =?us-ascii?Q?mSFmgWE+mRh09iM+5p3fmkr/IEIhfgt7C6cXkYUh0JW6+Cv4OrMt/iuabarA?=
 =?us-ascii?Q?ZCtvJWinXdEaf1k7QyluNjgLO9wYicGxl8zdOxSdT7YO5FLwNo01m0RicI0u?=
 =?us-ascii?Q?JsQca1mgqsZQIDH1otGLlrbAoV4xcsTpDmBNNPt77z3QU4tcHE/qU5c/DD9F?=
 =?us-ascii?Q?7HS/FqiUsy9RaahcnEU7c//tNWEMwQiXBRkBaQk8ihv5/z2jIKVuzfLcQ3HA?=
 =?us-ascii?Q?rJCoYM/VcBvOtrBxfLaDB1BuyuvdW34YksjYbx5qU5js3UV/yaIsHv1ZLJe9?=
 =?us-ascii?Q?hEPpNDGBbqOSazkARNmYIvmqxChJ/7ME2iZkSRY6pL3E02wqskz13KkincD6?=
 =?us-ascii?Q?r8VVre3Q8V+LYJEKYt0SiY64+pjYWt3fZMHAckzMgucUPI9m1+AZSP235ddE?=
 =?us-ascii?Q?z8W0w0wNFio1MbHu0CxfaCyOda+5Vz8ZR1hcQmfILs5sDOaY2LPXicAiuXO8?=
 =?us-ascii?Q?tF1vN68kp/DyTzh2QOmwnatpw/M1HDw3Kxlmhff5CWRln5sAVIvlKBp+aC0M?=
 =?us-ascii?Q?dCP5R1kJPbw+Y29ouC/s0Qylvd08FiU6Jn7xs1TGBPGoQAfEjDmbbcZFzAeo?=
 =?us-ascii?Q?Y4qLQ7uXGrrRLea8wOB9CaOmEF76xK1SbAcoEY6w?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f2c3a4-2514-42ca-c621-08dbeab87e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 17:37:11.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syfyOadwk5lb133qPOt4W6t3KMWCJHu+Gsj703iyhcenf+J5IluPTvdXWwK5PWwG2jMH877mPcQfEK34n6Cw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3452



> -----Original Message-----
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Tuesday, November 21, 2023 8:55 AM


> +	/* for each interrupt find the cpu of a particular
> +	 * sibling set and if it belongs to the specific numa
> +	 * then assign irq to it and clear the cpu bit from
> +	 * the corresponding avail_cpus.
> +	 * Increase the cpu_count for that node.
> +	 * Once all cpus for a numa node is assigned, then
> +	 * move to different numa node and continue the same.
> +	 */
> +	for (i =3D irq_start; i < nvec; ) {
> +
> +		/* check if the numa node has cpu or not
> +		 * to avoid infinite loop.
> +		 */
> +		if (cpumask_empty(cpumask_of_node(numa_node))) {
> +			numa_node++;

Since it starts at start_numa_node, we should consider roll over at the=20
num_online_nodes() like the code below:
				if (numa_node =3D=3D num_online_nodes())
					numa_node =3D 0;

It should also check empty for the next one.
And set node_count =3D 0; after the loop.

> +			if (++node_count =3D=3D num_online_nodes()) {
> +				err =3D -EAGAIN;
Consider return -ENODEV, because we are not asking for retry.

> +				goto free_irq;
> +			}
> +		}

Thanks,
- Haiyang

