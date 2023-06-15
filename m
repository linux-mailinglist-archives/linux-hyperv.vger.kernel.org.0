Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C19730E8F
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jun 2023 07:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFOFPT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jun 2023 01:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFOFPS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jun 2023 01:15:18 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020020.outbound.protection.outlook.com [52.101.56.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13A26A8;
        Wed, 14 Jun 2023 22:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emnTF82ELj/VgYDJDWMlXq05cU8xSg95JdSbqpQxUdKbsFvPH47snFm43s+eWVjLrAesUXdTZ5qkEvFciZmxwPTnhQqY/Qlffi2jUbJAZkrZRg4NOaj2N7LUHLCyelFTnZFDE3veEAfaYO2SzY1TmebgUcvAjyGyLLjCaL9ho6Hl80G+zVxtGgB2CgVb/8gt6KEVrrH08dEhgri4eMvcRQQcCwKR0dH7iDsC0UlshH2pstzELv6Fy4YNQsvc97VwZ2q1W5wxD9OtNl4RsozNPPxc73EzWGGcMeXumIHS4xavG+OGrtg7vNNi//fM6wnu5SvwjZOyD664zPP+80vY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1nnZmNbbo+6N7H+QVRyC/F7aMnM3lvbaftD6XJIvTQ=;
 b=nor2dze8wo4izizrc3gD70XMQaoB731s3vpu4YiVLgbPHX9F77bK6D++9mi6IZqnaFAy1qQonO9gKmzbWz8sYQKbjZe9v5t8A/Jo8Gg4kXmEUKc9iPmcPDFLfTMlTXp9R99jynt+9oll2CrVzHYKOJX9IwsluX5jtJCAVMwV0FllU88Q5Xk53TMpH7jr+wizR1WPZYXGMwsMloM6OJTona0nUNY6dT/7aDW7CsyiFmmXka4axxQl5jUFCXu2nIRKquNX3DJg+q2cagSJYEss8hdY/wKXIYR3rtu1cQDpeHWDpmE9Y4T9LWDMKQo9PbepYHVM1SZPxZVXOfbq6XF8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1nnZmNbbo+6N7H+QVRyC/F7aMnM3lvbaftD6XJIvTQ=;
 b=FFgdI0GczYQ8KQtfP+LMJk3trYbtrDtSjIh6sU7vKmKAwud5c6zE075+uuAtIcjqGJr34lvdUgS8WoxRIg3P8MScLslDsMO6ed8m0a7wgE4qicc03Ec3zFpuERJg+1S5ZSVllnFb+vOrP8dKcSfEcqOWXOrUJ8+Pn4qikntvazQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by LV2PR21MB3060.namprd21.prod.outlook.com (2603:10b6:408:17f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.3; Thu, 15 Jun
 2023 05:15:15 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6521.009; Thu, 15 Jun 2023
 05:15:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Thread-Topic: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Thread-Index: AQHZmunMDcX9sMcFW0imDwJTULveWa+LWLrQ
Date:   Thu, 15 Jun 2023 05:15:14 +0000
Message-ID: <SA1PR21MB1335C1717D91BEE7124E2619BF5BA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4b887ed-4970-4bf5-ba16-f85bb53353b2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-15T05:07:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|LV2PR21MB3060:EE_
x-ms-office365-filtering-correlation-id: 68eb43aa-1329-40f5-ab5e-08db6d5f804c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORYeXzQGA7dw0Xp0X7skMaOvM3K/dxhJwNGvnpOe4aezLKjvDgKngWp8ktNDGmSs4LgdvW0lgoe//sBvKZ5GhtQQWi0uQ0g+2it+lllPdqFT72XjswssuYsYi+1NgpBt8Qi3lE8s3mpZeYXK+Tf8DERXfy5ooDVFxxkC/FFbYQak+TNRWUqTh3uiG/NjGDrUFxE9TGiX88pePC2B3K6FFxCqjvvVOIfp7KAt7XheqI8+UzrPU1cyI8l6G/YXaurvYDT8nYKIebOGvvEdY9K/TNxc9SnnAbtRcL1zj5GogPTgN0vwzBsrpxRQP0ih0pEHttwO6L8PEKQPGa3FCPC8QlqyEOFR6aHsHdhiAwwGsgTbI3j1O8pqNiqbGS9X8jqt9W/DxxQ+KH226WQPFHjASg1ZDah9/KtFFPfe1t1YmiiYbbUERt3umZGd+VJrV86noG/OQP3F0pLXlfrS+TFYvufsUD4BzboiklkM/w0LeIl5K7cJEpJQL8YHsk85CiaXfNMOGl+02TUsLR6SlfYqfdWoOhbQAjCYB1BVWQh7W6l4PYUBd3lYyp6761sjcwKMhkNHJ14r+VsgPYSc4B1Jb5C0kequbSc4KIYUKVNdz+2w1ijclT16cugyekYnseoldhF/FMEBoYczpvb0VOc5bU3YDiCGuY8/XlcktEwtk6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(186003)(9686003)(6506007)(38100700002)(86362001)(38070700005)(55016003)(82960400001)(122000001)(8990500004)(2906002)(558084003)(82950400001)(33656002)(41300700001)(7696005)(316002)(110136005)(10290500003)(76116006)(478600001)(8676002)(66446008)(71200400001)(8936002)(64756008)(66556008)(66946007)(66476007)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pIQ+95pxZQ4eXCOiTEpxoS0D1JeojzICPMf1Q15eF3I1KOOJB+C7JEFV3uOY?=
 =?us-ascii?Q?mhm+/diB2otqk2Xj+HL43wp2XiE/ivypdUp2waKtTkpI0o67BNCd8fRPV/LU?=
 =?us-ascii?Q?7Gyr8a2fybFs+tFQ4GuacrIc82IcspUtqrt7YaSJo8xz3Ul8phREnH7psOti?=
 =?us-ascii?Q?3L8PJDIvZc8Dc4Jv5KJ7QtFG02H8EfWXzJ0GHnHM7iIpukXO2IKSsl+PBkRW?=
 =?us-ascii?Q?8/XM956f0/NpfwADdGi8oCQIxXFN/D+W7wruOtzp4QXWvkAjSEjPhaQpjrpg?=
 =?us-ascii?Q?yLSfiRj7xPNozjk+RsuaPFAp9xKM85cR5cAwO846xYgTszgyboq1ocoEoD8z?=
 =?us-ascii?Q?qyU5HhizzQjO5ixZ1ZfIG2Do+Uelu6l7Zy6T4bnw8ka2R9QzZyKGpK9J24sf?=
 =?us-ascii?Q?Blsq7SIBkrTpQRsDDOR9k9CNvgv5DElVlF//vGnnQYyBib2jZAD0PispomUJ?=
 =?us-ascii?Q?BjybZkYRTODgKuWhnw3G0M7sf3M5q+j0jWXT66RBT9FtEAdiIobcBR/17H7x?=
 =?us-ascii?Q?oPPiZadgFYmmmOeulDAvrV1K+gJdGuuuap3gigBUu+vzjkf6pxEzz8yD5Vwd?=
 =?us-ascii?Q?MI4FGQIhuC7169MHgHUAraoA1nFNqroje2GdUaGvYODFCX23/sbzs8QlFXiS?=
 =?us-ascii?Q?G258L7trac60Bl+BqdrQQiWL7mfFDfoFF5Ltsj2ALXNABBuU+WkE5SQUrL16?=
 =?us-ascii?Q?48UX68dronATeg46JzN2x0qBQANU8TO5qe41+lu0UX6Xv24DlkyTP7exCi3t?=
 =?us-ascii?Q?flAd1nKTNQM485k00xrY7kbkhfTWnqAVrwbBNmRaIsficxaUoS/OfVglMabM?=
 =?us-ascii?Q?KHRtyan8OzC7LNFxNXrYI06NxIkP0dzxYOzxB7yNFs4XHK5CmHturPI+9ew3?=
 =?us-ascii?Q?l3vbvWjIFBvA5kWgDGNSkBgdhkB7PhJepZvCynVzI2eaDtFGgl/Ok1eGwbtN?=
 =?us-ascii?Q?d92Xklf5zVeBCh2Ar8WOJl6kwwCGcb45JkHlq5K1SB0DHpkKGV1X0/Neiiza?=
 =?us-ascii?Q?tluANYCvqcR+6lvHigAh/l/n+OMuagluXMlQdqkrFWQheZv8N3khSpdDP5Cq?=
 =?us-ascii?Q?tlmfhwJFgs1i3ZS2UXWlOVMjNQoOZsgxoN8Q/RUF9419h3sYKIyAu4exY5ke?=
 =?us-ascii?Q?3Td9VqhHyqRdF+9zHIQuy8RtPb7jOQ3vLXkPFgNkyLScivm7s7HBpSu+1+PA?=
 =?us-ascii?Q?utGAoUMYZy2x06QdIiAr9hrhdceZ6kmm+LXOL1JQM2GwLJKSg0E4oylCx5Wn?=
 =?us-ascii?Q?u10SknSVbfcb0IxDvR0qiLKpXwNJWf6iSuQ3vy1Ylux8hWR86LbhL9QbldI2?=
 =?us-ascii?Q?XE/lpJ0jGsijT3YiCZ0aO84hp7vrGADIq7quNFJUpqF+1vNXrIGDB5BPGc8o?=
 =?us-ascii?Q?pi76DT3/U62oZb8ybdNiuVgSZ6EPsfbqJqFbt9k7QtIGvi3c7pn1/9JpD3da?=
 =?us-ascii?Q?gQP2WeJrNim9L1SVBOBDXobDCq/C+c6oxfKCIKpv6YyU/olLMy03Aey6ENZl?=
 =?us-ascii?Q?VAH9c7FZxSYWkLhWfm4eXbJ6iox+mL05iG+zGnxIqRKTUSW53tsG9OqpFMmk?=
 =?us-ascii?Q?K/CWu/i57iFpOaIWOKBiSCqX8tSRDI2ZK6vFo3fF4+k+HyrF0Md9J8ef/4Nc?=
 =?us-ascii?Q?rin9pZMjellNw4VJzgnQ2rY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb43aa-1329-40f5-ab5e-08db6d5f804c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 05:15:14.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hoQWo8f19vbNG6sfpr5AGpa+CjOCnfFgK3uKRKnOjbd9vtGqO1eXtmq2bM8cinK0RzONXvsxf1lr+dKhmtEqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Friday, June 9, 2023 8:47 AM
> ...

Looks good to me.=20

Reviewed-by: Dexuan Cui <decui@microsoft.com>
