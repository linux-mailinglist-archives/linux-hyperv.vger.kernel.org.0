Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA782B39E9
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 23:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgKOWct (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 17:32:49 -0500
Received: from mail-co1nam11on2108.outbound.protection.outlook.com ([40.107.220.108]:60224
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727971AbgKOWcs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 17:32:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2mTdbxyc1lfvcD2ooS19uTRHOSe56XUYUBZQwkpnKefdrFIJzyF+LBLkCXDfFC5FuutanjPCQTiA9SGdJ+wC/9INrnQNZrj9w0mnThWx9+CEnyF8/+Or9tyQDySGN50NdAEH8+83pE7AyoBBmWN+BLXQNPTIAHqHQ707i8FRjq5IdaZzRTZRRiHktu9lmQ0hnaMLDCZnOL8jXOC544i+A1NI5/OkbJ+84HI+yXw1XKMvXW0v41UiFoKg1V4qcgN5KUBMTeh2M1sujxO6+igdRRBhYTiMqKFto0riSL+P3NssBC5GSrihy2OrfpMFCqDznr+Kqw5cKA3OI9Xj0rZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUYgEgIPK9ttm3lP9vthk0pxDJiUkrjlvGQaF85CPxs=;
 b=nXj+schI7HUm5GyFeFhK3crLcm/HWbRhEjIQG191TaPexXW9TIIzE0IjpH8kbC+C8W2FGPAggWQs5bgQFBQhZLqxLFLkjwBvUmy4sDBBFhtT0UFDj0BsL9kU8ZF5HnjRDSlLLhl0/ts1bQz+I3yXYgKBJcy8YvJlDZ+w4Y9WJWtCege49V9hTjKP/3m51h6MBL94ZW4hOiRbcbQQyF8GQCllpcxkfq0CmZN8hKN4+ts73X2/LzdvbI4jh2V/gilC5oK8tXFxIofvBgC1ktxLoMA7j+ut14jLB0YYxHcziTRMI1SLONZfCsr161te6R65OHuI73AVv7STvfcp6A2crQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUYgEgIPK9ttm3lP9vthk0pxDJiUkrjlvGQaF85CPxs=;
 b=I6GgS0iG2Sv1Vj1XEb+CB+4BdBYIllvCP4ZbdUpeaGFBPRe1HFrPomxj/G/WBa9+Pw9vi5nhHS6aSAUCpiO7G28IVCL9k7B6DvQzph5JMv6ECg1ON8GAzLEWGAzG8EAXWVQm0UVgFlgxnZE/3XxoMnLbMTX3Dmhy5UR8vLODgcM=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0176.namprd21.prod.outlook.com (2603:10b6:300:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4; Sun, 15 Nov
 2020 22:32:41 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3564.021; Sun, 15 Nov 2020
 22:32:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] drivers: hv: vmbus: Fix call msleep using < 20ms
Thread-Topic: [PATCH 6/6] drivers: hv: vmbus: Fix call msleep using < 20ms
Thread-Index: AQHWu4m7xzn3Sd6FIU2NfKxEb258TKnJxwIg
Date:   Sun, 15 Nov 2020 22:32:41 +0000
Message-ID: <MW2PR2101MB1052895CF04FE8C1593619ADD7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-7-matheus@castello.eng.br>
In-Reply-To: <20201115195734.8338-7-matheus@castello.eng.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-15T22:32:39Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d32d04a-8b53-4d7c-be1c-a1c99c683e81;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b3774b8-8719-4d5d-85a6-08d889b65d38
x-ms-traffictypediagnostic: MWHPR21MB0176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB01769DF7B91B1E780C0FC968D7E40@MWHPR21MB0176.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afYTji+EL+lazNnH7/tmwqwMMLx5aAxy/hjRgGI65V+/fYOV0YrPlMOXiXZrD8fL9kP7WMYbcEXlKnIbA5S5PYBkAYuEmG1FSQlEMLbzvH/2Kbj0WwyBb6cTXEqw5IBkSWfpGZHmk9KQBOKpQtZ0DfWnpSViAPvGCHkGF4p51/yTOFvZHkNlMVx7pwWyRoC4V0kVVYrVvCUOWCwsRp6/NDda8ejXVL5MV7JVGxzOtTiGVY+oQ2eO9UM/mTPl4qBs4FSSjM0sq/b8nY+M12nId462+3esAtgE+fAa0UlMQ8B1oWHHJzht7j+4DI+5QvRBOa43NLh+dMgopo7trwLLig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(10290500003)(478600001)(4744005)(186003)(26005)(8990500004)(83380400001)(7696005)(55016002)(52536014)(6506007)(9686003)(82960400001)(82950400001)(5660300002)(66446008)(64756008)(33656002)(2906002)(86362001)(316002)(110136005)(66946007)(8676002)(76116006)(66556008)(71200400001)(54906003)(8936002)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HqB8tbH9NinRK5cRBM3GXtlfOGqxwxmz1vRHu6iFAa1aUQDHcZIV4Ld2MM1GboPkAOdSu04c63/mbuuYL3mArBfD/ZQ5jSs+21IDmpybdjv9BSyxUwUDtBkVJrVN8pNmbZubG6jBSbSW2s5JG+eZRV8tKmcyPIHRSKBLbqdeKJXPYbWn5ScuLBSpzriwDB9z55SvC6oJ0tBumfTDJSxuTeWW/qnilY6+D8A5+odNJbxEFyqwHXtdsFv1YGG+ccIN+Uc+L7CC6tg8WffiY5+Ve3P2G8d78Zrp16z1lne28KQA260TLMYruuOTQSk/gK6pW9LCfRx+mSGouQCTJIG5MogXhFHvpcBHVjM9oRPf6uGY6frgnsbt+BBaCt23g3hY5noGr7eZdsxJYn1DUDpZYL7d4EDycjp0UqEO9zq1XtjHdauPRqkNAtpJn2Zmk83RjYWzEb3V9xYS37Gzpj0ETQngEdPVlm6HcoDATUc9tFzbU8cU7QBdmA/7kNISoyzdlPBA76Q3IPPXXsoFrjIUj+NRZl0PPKAMLKeiqV+PPHP+THWxlvyp78/OULMvaVVh29/hRsSKSVpyxVcvz+d/qagNhFTOsJq9L80w6sk/6DD92C2O7t9QWzMt1iL2U14SZW3MB0lIj8x9AJqzZ95Z82KjZ7MpmVV2EaSGwp9YBvoWpWyBfXKwB0uMb6fcgO2JjZTz21HRWMYX11NdA68Vc6HaNxOfqQb7gAaDEBGRnIY76LTVv/1kRJt+X09w62qbFH373MnJD1fkZANanknqWy9RlFomhLkbyYTPuV7MfcQwiUvm9HJtRNzgCLfdqP6DuQozqeubfBQKTNJpM9AdeyRtgIFX1dJC/zGv2b+DsFgXwuqSl0zid7UBDKvcCnR1XOPY6J+87jOJtV5q+lKf9g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3774b8-8719-4d5d-85a6-08d889b65d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2020 22:32:41.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSXQqmDT8iQXgo8CGgHH8qAKyX9ZEGERwjqjB3rr2LYmRxcvkjt/HL2HY1lhDh+yryq7FKyOhqAsJE62/Ov/Bowdz1/cbvp/QYUgmt6uQYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0176
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br>  Sent: Sunday, November 15=
, 2020 11:58 AM
>=20
> Fixed checkpatch warning: MSLEEP: msleep < 20ms can sleep for up to
> 20ms; see Documentation/timers/timers-howto.rst
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 774b88dd0e15..cf49c0c01206 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2382,7 +2382,7 @@ static int vmbus_bus_suspend(struct device *dev)
>  		 * We wait here until the completion of any channel
>  		 * offers that are currently in progress.
>  		 */
> -		msleep(1);
> +		usleep_range(1000, 2000);
>  	}
>=20
>  	mutex_lock(&vmbus_connection.channel_mutex);
> --
> 2.28.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
