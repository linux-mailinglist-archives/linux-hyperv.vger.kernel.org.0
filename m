Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB478775A
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Aug 2023 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbjHXSAB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Aug 2023 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbjHXR7i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Aug 2023 13:59:38 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020022.outbound.protection.outlook.com [52.101.61.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EDB1BD9;
        Thu, 24 Aug 2023 10:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb7h6+9Rzk0VYs58XbI2eVeZY1N+KHqnb1pkN3eBE9dS3wsHOg5Kka2wbyRgMPBasV3jUMg6MqIMI5kJEqxAJYQTZW0ZsMMaIh8JDgj/JWp+Qfy+w6ql68OjPIqPq7WOCTF2ZOAsMlthjP28uBpnrI4+lnTKQ2d3aE3uPboYM0nwETGAzkyZiyRcYguAvEgSgQC2nesjWzAwlaTEbDGJ+/1iJa8oLbhIjIIbJHuEwXj6G/d/YYQY4taOFv3LKMBYhvHmZKQBVUjexzSK0t7oe0QIGIa03dwbI/kSmjsDpyjIFZ8/gBKQetkVBvwAqzydn6pwkJQ3wVx23+VhGEsSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQV9gORcV+mj1Erph0VXEaAyoGQVIEfxtyp1L4PcGlo=;
 b=Sd6YUlJ39lOCM+N0NKL2KmZ1Jx0b8HeQ2zBBPg8nm1BJ9b05CgjfhPawOP75H7X042kGCvtngt8sXKhCerkDjCXtaoGWzXZf7YieUkR3l1mn3008vTvZQG9jlYzkMGhOikgicJVFF3U6kF1YeG2vOnfO3qBcvHXIsOUS1l+eAzYbXbTqxXmUBbwZbJBoSJIlsf+3vi1gAxz5xZ7HSTJDEDHUpBNIEzysKE/58aAFD8u/pJ4tQ/Wxs/2DjofZbqMuX8QA2WczhqRie2WkaQhXsHYIwx8cqhEowD9mtTbOBBTzZ4BHp2ACQwNvjgQqPjxR9UigL7UJLOULzsldDRoamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQV9gORcV+mj1Erph0VXEaAyoGQVIEfxtyp1L4PcGlo=;
 b=Xo7gCMawUNr+gi9/aeaHpCNelZHjjC9BoC699UM4O8YKZtU7VSo9tWvQpb2aL3gKqupNGiRlgTa1iJNWYmT1j1PU1X+oXvJBtl4t4y1JcwjuhQDuiaIt/3yeBLx+DLmE0a31y0Gn+kZEyRUMpTjdyCIbHy7Kf+L5TiJ5FqE1ROU=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH7PR21MB3332.namprd21.prod.outlook.com (2603:10b6:510:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.6; Thu, 24 Aug
 2023 17:59:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.005; Thu, 24 Aug 2023
 17:59:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] x86/hyperv: Remove duplicate include
Thread-Topic: [PATCH] x86/hyperv: Remove duplicate include
Thread-Index: AQHZ1mGQa5urctF5s0++UXxqZwKRtK/5u+AA
Date:   Thu, 24 Aug 2023 17:59:32 +0000
Message-ID: <SA1PR21MB13353456E5B6AAEE6CB9EAFCBF1DA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230824080352.98945-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230824080352.98945-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=32e26831-6520-47ca-b8e6-01052bf776f0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T17:56:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH7PR21MB3332:EE_
x-ms-office365-filtering-correlation-id: 2cf60e56-fbbd-4a55-8d2e-08dba4cbdee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBYaSCGhKROZ6yAPfi2UmPGk3j2GuaTz0fve4suXbOqklW2pBFQ0QDvqDn1ZMv60V1aJKPhT1jTMkI1QHzPNyf+fjG6xNmtQPSkq6IFprUxG63d14HEH0GqbcqK2HtqxUQ0DyvaAdw2+3QZ0r5lTRpPR2CBuz6LSW2hW7VTFYLOnCdzSIeWcNPu4ehQpyztoEW6Dx6G/5fxub+q5wEUz6XQto5Vh5MZvfNYNcN5GtXkf/bpJW7PkWICsh7OxUubL3D4pohP+28yo7ZHotW3Xduk3ge9zMxpEgfF6oS3H4RopJyW+bs0VQhnzWAgcdu9xgvzqHVc8xso5GH9jkadJNUP5iC8I07MbuZvdC8p8xhPYhcZfy6dE2wNTRWB0924YdO0bo8Vp/RfU2CGrM2DEhgCY/2BI1rEWh3sO237zvvDGLKMFxW7vgny6udfvX6wJXM2fokQcp8z72/ucj3znY5/OsFcyh3UqUrZgJH7OzfOWhM1Xv8Ok7r9YTaloFNfSb0d54pWtaFSO8sMjn2NydqMYXsiSVqUV68XX2sDCvbq1mXwMXMZU+yxMYRwsDuX7QqQrtXmwGgU8jKXcB/mQUAI4awBUDWXtTZ0Yhdfu8IN3uPEJUSL2NzQzhFdenFSdKeT/XJlWdB6O3KWSXG4JzsaG9G4hPJfQ2ZyEBm91R/j8hlfcE2bOnQNsYuflnj3k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(1800799009)(451199024)(186009)(12101799020)(6506007)(71200400001)(7696005)(9686003)(33656002)(86362001)(82960400001)(38070700005)(82950400001)(38100700002)(122000001)(55016003)(83380400001)(2906002)(4744005)(10290500003)(478600001)(110136005)(66556008)(52536014)(76116006)(66446008)(64756008)(66476007)(66946007)(4326008)(8676002)(8936002)(5660300002)(41300700001)(7416002)(6636002)(316002)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c3nCN1G1GgubnEvqLUfvmXcVGJb5QiUfxO72lhcTmabREbJ8ZSnp8RjLEj6p?=
 =?us-ascii?Q?A1BoqRVKyHv0MNSU1er3HgBClZI1d0lMu8rSD27Z2fo9am18cMOK+zQ06UhJ?=
 =?us-ascii?Q?LpkbcWJYRZYa7pnXGUw0i3b5iAMZggbZvaSKFb2//ep20nu7VOfsKVv5yzap?=
 =?us-ascii?Q?mCU7MmZVFfo0FBrgjsoM7aF9o+H6Nb98wSWzsVIQOQG2IakVPjTzqor0qKuL?=
 =?us-ascii?Q?W6+nH97ysGjYFjvO6kfF7tThkbMddsPAPt1ivI/8WorcCysKalQpe9zCQAJ7?=
 =?us-ascii?Q?OJGIDEw88abyM5sQ913GsoaZXwpQvTdyEhxE0Pgn4EDGm9K39fMOqIkfzees?=
 =?us-ascii?Q?wwRUZwiKaOrp2G2hDfj3P01MEvyj0WIpzTs3PW3az9g1KwoAt1Tzv6rpLfkQ?=
 =?us-ascii?Q?3Hk4b9JDWKCqvlhJCMdmZjbYjysWTRm6xdh7I96uVkK+mKMDTBf3wKvJz4Vi?=
 =?us-ascii?Q?Lq6OF/ay9NrSwR12FwbJLK2ksq4ZfbIOh2cvAqGNkj7tDdB5Upgcnr20EOeO?=
 =?us-ascii?Q?FrXIb8oBSEXDdzA9Syy8KdVZk22HRPVbOE4N0dtrC1eIaJ6dguZWSEnLSu7p?=
 =?us-ascii?Q?VoFONDAbTqbPTEHKFsb4kjeEhqYJrtIHjTUobHVqjKW68p9Cw/BfMaf6Dz6K?=
 =?us-ascii?Q?+hLWV13DLpZ/ef2t7+M4kBPGLmgnoUfQmJqkhPjFS5DcI0Ncj2eZOfEbqCfv?=
 =?us-ascii?Q?oSU00w46eT3HuTonyTTyqlYm3A+NNyPeI9uGw5cUWT3BtjfKTgJUSriJ3UbJ?=
 =?us-ascii?Q?PTfh2i8HfRspfw3+IcL2J4T8m78zwWZKKvT1SNZUcsLrw+t/Dw1Aa7ER4Grn?=
 =?us-ascii?Q?lO1zB+UXAaBgSlnfTccdw/KYLH1kmiql+A2uwaak/amabhYwMpBQlS7UO0sr?=
 =?us-ascii?Q?NIe3WuUU1nMq6a6YckTQUhlcvo4OODfor1kmYzdjwCWM4Q3bg7CQThzs5Ixw?=
 =?us-ascii?Q?4khqO0D7WSr/G6nXqLF/I7kuLkkWAcGL89gitEp0fbQ7lDHHnFyydZs/0sKo?=
 =?us-ascii?Q?ibDdQUiJdvjKEIWhSFn7FI/OOLbOVh+qKz38af4nhkG3jFjJV6d8W1wPTq3F?=
 =?us-ascii?Q?cPB4un4LXn48ZtOui1bluoZZMWHFuwKNrkaVzY/3WRbTsHczcuUtQtDgkOV7?=
 =?us-ascii?Q?yCtMpaJ+hU3kz49ohzH/zIq1iqnjMgrv2WzaM+RhzPHLOCXifOMogEWvnuIM?=
 =?us-ascii?Q?DUz0ryyTk+YRBckNQCF7uhRpxvP+rfw/+V+7o46G8orhnNbIkeLmaz69w7vA?=
 =?us-ascii?Q?D5F/Qf0kKWeY0sHKUCQotoc5A9/GpRywMxqMp+qz/twUcggFhoS/FbqCrRUb?=
 =?us-ascii?Q?LQ4DCql5wi9pA8Lq2hpZMk3XfB68uP+G75IGmG6QInTXXzgSh5k4LCB1zRDn?=
 =?us-ascii?Q?IffWDGLsI4Sl5yT9V6amIbJrm/IMXyI9PcJtDIXgA8Z6co+GgVls9rVWyf0+?=
 =?us-ascii?Q?h51gl5fI1jRA4y4KAWv3zoIa3NQXWNQrLKAVArvlHbgA1HF83dkb1gN5gPeL?=
 =?us-ascii?Q?RZ9WUM+tPIroIPEvRR4Kllv+JFGkIPUHQ5S3ssVslRYurxKRgpscy8YVDyWb?=
 =?us-ascii?Q?WKG2RCLn+1QUb7wZJljFl8lNO5wUd1g+Bduo7Nhh27/wWDrKYxSh6/92teLx?=
 =?us-ascii?Q?ZCyFwjB+Okeg3ReSPZDgS5w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf60e56-fbbd-4a55-8d2e-08dba4cbdee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 17:59:32.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qga/hHRiQWX4r6hRla8VSmoTwmc2Ju1whs3yn6D+a2vk5j/0CtE7JVbbFtRNkGcInwTUQcY1tEy9/H0gLn3Dzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Sent: Thursday, August 24, 2023 1:04 AM
> [...]
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> @@ -18,9 +18,7 @@
>  #include <asm/mshyperv.h>
>  #include <asm/hypervisor.h>
>  #include <asm/mtrr.h>
> -#include <asm/coco.h>
>  #include <asm/io_apic.h>
> -#include <asm/sev.h>
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
>  #include <asm/desc.h>

I wish the header files were alphabetically ordered so that we
would have avoided the issue...

Reviewed-by: Dexuan Cui <decui@microsoft.com>
