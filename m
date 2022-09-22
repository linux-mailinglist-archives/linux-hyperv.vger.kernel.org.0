Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38585E6FCB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 00:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIVWkP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVWkO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 18:40:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E4844CE;
        Thu, 22 Sep 2022 15:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxSOulfDcCtFohyDvh1AGdR/entqXg966h8xbaoF5GOqv6HHljv6OAzb2eNbqNJ+ByKv+y5/O8kKEZxZ+DtWwY9xpBesmexU8UUN6M2QuocXqF1gIudA1QwGfUEXN2TRaaYezOm07AtowinhutDz+71DVt490gZKsOSTzuZMpLvBsyPZb9DJgx+QBr5eoWuE3QqZwt+0/j0lld6rX76M80HPfKRGbXcOKasG2GJulAS+ngAxFrZnhVlaASG/IQPY8s1T1cAsLndhS2PX5tAKAPW9QnQrURzhNsvA3GAfA1kLFkvwEGcE6f33Al+vd4zXE+AFHZUOp1P7qhB/p6ryMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jMRfQ926+Nip4rT9buMUUhii1URZ3StRI7F7bh4IdQ=;
 b=R9xKls5010VAexBR2MRl5lYTL7AYG60WASq7OTRlm/vBddwlfYV9BqpUIf2iM7x7zoHtJ1ul4xWe1KniJSPA+LUF+ske7f6ONtRpDXtmNnTrjZbkVET0gbLnTnXNvVHYA1N1A4VEJpmMCsW1EJCIf9t/twoYNarYnltIOzFnp4EBcsxE8nd55lAOOfTmvXbjlMd+qD48yR1nosRm6q/g0igosymZWjLelnRjBvr/7dhUPBqkRhkXlZDUwGVRG15YPWXfe7+I60vI4Aa4iqCPGRUCRELr7VMBCpxEPNKD/PDu7/ca+Ahqp1bvsGT7VkshyLWklj/Usx0kJbR19uXVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jMRfQ926+Nip4rT9buMUUhii1URZ3StRI7F7bh4IdQ=;
 b=giJ/6LT/8g4/hAMKUAUv6WPE5zFQ1Ha6ahsF3zCs16hBp5u+iLga1/RGQ3pmRl1y9yFhXiaztqGiyNsIPRfongxG+o0i+UNvA1XTRXR9Yhb5osPLOa/Qy/bQrEs1vAFqm8kBQFNPT3WzFfYAI9jlpSIKNoqm4ikz5tYo5JyU2co=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3657.namprd21.prod.outlook.com (2603:10b6:8:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Thu, 22 Sep
 2022 22:37:27 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5676.007; Thu, 22 Sep 2022
 22:37:27 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix kernel-doc
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix kernel-doc
Thread-Index: AQHYy/J3ZpV6gN++cEeSQfFdmzuSya3sD00A
Date:   Thu, 22 Sep 2022 22:37:27 +0000
Message-ID: <BYAPR21MB1688D522A27450BF8F0BF067D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220919063815.1881-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220919063815.1881-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dc7b87fd-09c2-4dbb-be68-175629cf37f2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-22T22:35:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3657:EE_
x-ms-office365-filtering-correlation-id: ef703e4d-72e4-4232-66c0-08da9ceb0716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94/IXFp2HwAe2QrfdJtHTJhFDi3ZXjm5b9LDUi5ehN9Hcx9vzehm65ybN4z1vysyhvge2oHwG85P3NdKbEgpFAw6lyGprwFAEYsvyb7OeC6D3aRoLHqU5Ct3DGPN/R2A7HmlH056+GAmV0akWsXIBT/Wi/sLrMKCQwlOQr40r36sBmWcd90ZsvDKydl/qVfPwp3TUs+cN7JjRvAKnENBrzujRTmGz2ZAx8xUy+I7hdDcAFRIC2OEA2O946UKGf821CjMLNKcnVeWbCJ9QfTN+EHNU/e4b/UY5V9+DpEGIIrrFMKnXmQtpnorNPNGxbGq9XYxgb0TNwTRCFItx6HVmgbOGkJP0EQS1JRG/NpY9AqTcTiRMMtmnZs65Sgs3JYxPMEhG6XCvzlGkbhcDmSaBMiUj2mjtWWuILMRgaCkF0NXxExryUV5VSG2Iqk7nFd57CdyiRWavw/T1rdfzoJCu7fYJDPs6JLO5mnFYe9SjlwNdLjMY2TPir/2CxrVmvnMh7n8AkWP71TmCIohYx9RFdTQFhzh+Ht1t1CfBRjGkBP1qpjvU7DyVfjU/E4ML5KKRsN3oo6rF9Whd9h2H2VI0zrllgZF8v14wIZTYdlWrnqE8SKNeSIacNNgQ4JSx0OhSle+SuY1fJmacWqLpAxeXi0y53nFr2g3Ipp1NJKkPI46dlRCCq1/iKcIIaQ/lF6tbs/D/lC9kltsgpXu+SidAe8bEAscFQrkX6ywXolrEoF38ol1dYfMIWrup7rv620rT49+QWGnQQV2uEU3FZdc00qYR3sMqPSDGI2NTRkXNzOdjwupSlyXTNj+IXRzp5LX3DhZpGFhUW44c4MbhBc7Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(66476007)(54906003)(110136005)(86362001)(71200400001)(6636002)(966005)(316002)(8676002)(10290500003)(33656002)(5660300002)(66556008)(4326008)(64756008)(66446008)(52536014)(4744005)(66946007)(76116006)(26005)(9686003)(41300700001)(2906002)(186003)(8990500004)(122000001)(8936002)(6506007)(7696005)(55016003)(83380400001)(38070700005)(478600001)(38100700002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?famuSrNUJMnXOKyCJUcjFpar9/WW6g873PR1lpoQHbW/br0CJ3XJfKvw5GY4?=
 =?us-ascii?Q?2Bt0jyFbeInPKBgTmRB1In+zZx3zaXAQUl7UzenoLbX+M5pOYqUkbhcxNCJR?=
 =?us-ascii?Q?t0ty8pSNAsapAS5IZS2LcYcwpVj+ib4XN7aYzjIb52rdL43PuL60ozkz6uY1?=
 =?us-ascii?Q?sbjIfUG2pF2Gr9y6DQmB3lQgkcVQ27x5+MULBxa2p+SnH3wQLdHFfWWWWA7d?=
 =?us-ascii?Q?p26mqRTmyngfCt7DoCQyFU/ZcI1p6/kZ4OIydjPhUK/4gpNQAztl+h4+3AXB?=
 =?us-ascii?Q?dmjkdkNTFVgeNdOBTFuAAendr3QITkDUDienPufi/k71CSF6wcAuREjPD3lL?=
 =?us-ascii?Q?f+9F5uVMJaCQA/mE68faTIW2OXpOnUfmivTVkX7cYACfWe9bSk535jQcVPZ1?=
 =?us-ascii?Q?xQ9IcV+hZ9Gb3CTsNNWWv6lNIKIsfVNN5n2wSzb2dLHuS6h+eHsywmpX02tx?=
 =?us-ascii?Q?3MgEZIyeOSe7LwhYoxNoPRHe6bb2yZptfZR7vfPVTcMr7gbQFjFnzB4ZfBR6?=
 =?us-ascii?Q?1ewjvsDX1QHcsuGFRnA76fM+eBqb3A7F67rMnwFqZzB1Gzlu6Ur2XPy8QXTp?=
 =?us-ascii?Q?fzjEyjBknpGwpSavcfaW2RGgKYsFxR1xNbNX8S1ZENrt8sQtj9P2P2A3z9un?=
 =?us-ascii?Q?dJzVjyQB5gvL1djTAJeV/rN8Dyp1owBH7sYrT11KhCthAIT/9B7gY46wRvih?=
 =?us-ascii?Q?BjV13tcxRUnvGWffvsEypDUu8Coxi3fHloyEjPbwAlQfvez0o7nPJb3DGhGO?=
 =?us-ascii?Q?0Sa5nwevy/21qrROZv1NjB6CesFo18jlXli86cnULQVkN3APcZjXbpNJAeJ9?=
 =?us-ascii?Q?5DchHwiNq9UUr7+hDP/auaxsaLqsxwR6NzX5m0WgjY4NUK+tyNFk7ejJk4o3?=
 =?us-ascii?Q?QhFGWinf8HjxG7F4+5UK/B2hA0d9DKUpzHef0ndqN46pnSQ7yjkBjXYhi8gV?=
 =?us-ascii?Q?zjATBoAs8cixlKjr0YhN+KUu/QJHu6rYuS1MQ0mPtR4DF8/Y2CyAirmnX8Ig?=
 =?us-ascii?Q?pSmeIj4/CxWDz+AVCIC9KXQJHhSsi8bup5I9TFeuMXQ1eoiJZMEd8WcDvOuJ?=
 =?us-ascii?Q?R9mrnVs8b3whxKmrp0uDupavuFoBcpsMHmrqND2fTL4I7QURrJYowE2/QJrN?=
 =?us-ascii?Q?HE5055MCxYXssBKqoLxOo3v7mKeDz6wcRF9/9jq5ZsprvLH4seb18LnuNLHv?=
 =?us-ascii?Q?MT3elEaKSEmKwqY1v4lOa69u9KVj0ufiBQD5XeTY7UDWZDfWJeuHT2IUXGZw?=
 =?us-ascii?Q?P9mOsRw0pj9hqFrMiNoqbITxcBGvRSkldlswtukOXNA21tM/ocDWMY5pdpg/?=
 =?us-ascii?Q?Qhz/dHP90LSQa0v6RATzk91Py18sa9l2dwC5v7t+2cDR3MKQHrUoLaLaH/Zd?=
 =?us-ascii?Q?HA61PHtjaB9EA+J25z4Ph/gW2OsrusyNCbL5YaQ+Jq/gYX54q0FTfjGffJgx?=
 =?us-ascii?Q?yCoy3ktXjgwvc9HcfRNN4UDETr8TQehK8xfEilHBR7u6QtmaUJv6jdFKskii?=
 =?us-ascii?Q?opB2CVln9uRYGida03hayB/wUmyeTCQGyZ9q4KfA1hoh9OhpP1iz8CcMLVOw?=
 =?us-ascii?Q?6F1Krkim4k4nF9woV7MVkeDxs3xJk2VPBN9DYKROuI/gbQ2oTw/Sscc2Or/V?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef703e4d-72e4-4232-66c0-08da9ceb0716
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 22:37:27.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YOJ/ylspMMZA4YA0RgSp3O5curE4EWsW+csqjSrlV2gNpORG6rbNZrhwZI+T9MpZZpHxlhl5X4vg5xVIpvpHDXZl2Ak8cfuASafO0AwOYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> Sent: Sunday, Septemb=
er 18, 2022 11:38 PM
>=20
> drivers/hv/vmbus_drv.c:1587: warning: expecting prototype for
> __vmbus_child_driver_register(). Prototype was for __vmbus_driver_registe=
r() instead.
>=20
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2210
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7b9f3fc3adf7..621702a1725f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1573,7 +1573,7 @@ static int vmbus_bus_init(void)
>  }
>=20
>  /**
> - * __vmbus_child_driver_register() - Register a vmbus's driver
> + * __vmbus_driver_register() - Register a vmbus's driver
>   * @hv_driver: Pointer to driver structure you want to register
>   * @owner: owner module of the drv
>   * @mod_name: module name string
> --
> 2.20.1.7.g153144c

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

