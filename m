Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EEA75122E
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jul 2023 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGLVGf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jul 2023 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGLVGf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jul 2023 17:06:35 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38121FCD;
        Wed, 12 Jul 2023 14:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWHlQjHw0hAX5wbicVwYPUmuxufzNyRU91xBUaLUHPPf5/T2gtF+X5D07WGiU12zJzpRESTSAU5UxqSNhkfPlz9qqRY3LZ+SB9OhpTHG88VpxnnIkwQu/3aF97M6OvYRTzPs2N4eKyk4Bot8YUORP+CdVFaCmhrw601sA1M5mJzaxS4IXbylzHJ1qBIv+peE8KPXi0/qudn+xtGOoBKCJO/BNRcM3XvvJZYrXYwa9kkFw6nL4s+uiK8ydxDoeBucwplatJuOkHsOizJpZ6ol6zvaYCSCYskk9ABBT3vY29fyKIadGp4Fq8Xs3+HWuqZh7ZH3gAQXxdsBBUsbW9STJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzWmBytRvXZyOm0S2LjrFRJabCxxqGequzR9T4UqAZE=;
 b=O50TyHvbfeK/sU9zrfP0TcNbzB2T6BZq2EZdiyQWH+/DArQEInX8jYqTXo6uEP4fIFTvrcOUYQkdfU38jh0vQxEbQ7ZwJTQ2/ZGyem7yYOuB2OT7eXyUu8aaOxMupKSRI3h79kSAyAHZ9lGDcNepPHW145dYeiowux2OALesM2c7oP22Vp4owl0hXXsA3Im+3edYoeK6N2A3OS1762qqa2Fq/wW11ms+YPQXOVL3fU9IK+ypSJZmr9t4cEDaUBq+BPXO3MQr5WhpMZEOSijEmjIi/H7RXznenMkHBafJ+YQom5MRes/wVcFxWSoYhIPItwjuMuk+cCE9BYfORGufvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzWmBytRvXZyOm0S2LjrFRJabCxxqGequzR9T4UqAZE=;
 b=BzM68uZDwR39UmOuvG/ivuyyB4FmPS4VUbsvyFifUHbuDcZK+/E0X3TefWL421QJZdlfJ8NdGOkM1VHuJFldm+DkgQhd1/boXp9eLeV9LVTBmraIAaHHzcjOSQCtMqfuGA90rEGprKqOjDC7L8EchTh06xb/AlFM2/4VZKCxd0U=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3662.namprd21.prod.outlook.com (2603:10b6:930:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.16; Wed, 12 Jul
 2023 21:06:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::275c:198b:4685:accd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::275c:198b:4685:accd%5]) with mapi id 15.20.6609.003; Wed, 12 Jul 2023
 21:06:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "huzhi001@208suo.com" <huzhi001@208suo.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource: Fix warnings in mshyperv.h
Thread-Topic: [PATCH] clocksource: Fix warnings in mshyperv.h
Thread-Index: AQHZtLNOtSCJz7hO20Gm7er526V/Ma+2nyrQ
Date:   Wed, 12 Jul 2023 21:06:30 +0000
Message-ID: <BYAPR21MB16885FB2E77FC9ADB1C8B48DD736A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <tencent_7A4BAF2CDEE6AC56AB5ABBCE9CA1C2FE5205@qq.com>
 <f5f5e7f2627ea55d81bc2d39420c40e8@208suo.com>
In-Reply-To: <f5f5e7f2627ea55d81bc2d39420c40e8@208suo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=86bfffe9-983e-4100-b3f5-f4bb46034fc3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-12T21:03:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3662:EE_
x-ms-office365-filtering-correlation-id: c1c35e10-98a7-4281-7149-08db831bdd30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eM3huGzdMYfyhW2lfYPlldTCMnAzjSTGysfTpULXS04cFmPuqEPiLCBHzh5d1k9+GblG38rGcO+eCykfwOTT99AKhnfWYbphPREREZF7QMiavxROFA6hnsmWzB9yLH+71fFvPC0xeCwHDIj2vADc5zdmpwpXvsiYUi+BzV9u0LSNtN+yaAqy3B1+WP711W4VfdLItbFaAUXe1vhI7h7Gxwc2BL6SlD9UBT9Pcs0yp2RmEmiSHXFIdYMrFxa1+43/nbLE0MnT8d4Nx3epJXjGuxxN1WigDnlRgKF6xWiAZk2Q7cqg2L6jmGauk7y0Zat7kIv1HTkzakf3aVRFtfrtpnNyDL3bh6MK/dgmg7291lFv69fL+szuC7iANznxbBxNqUaY2xkJtpJG6N+4A0TRCOuaEI7FNmLHqcgjgehGbZDjabRliT9ovD9YNjUAbjR8LjKUplUm4bDKTLWUzFsowCDlcuSw5+PdCzk1r0E9vsq2fFUiTtKHpgg63P9eG9quMzudddRqN891wNyXdOEh8hYNCBl673TiFInWSMPih2jMTE1DonyNc3IDz5bOg8gMGfIDQnbGjWAxQYzz6oa6ymmeWlvfUjN3oJDymNzwrtS7/wcnONnhXiseEav0Y3SED/OJaxJYNBj6iygTndsAtEWtunCNby3RZBXWU8Yi4rC69p00QI3UaGpCBuOPWF9X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(9686003)(83380400001)(6506007)(7416002)(186003)(5660300002)(8676002)(26005)(52536014)(8936002)(7696005)(71200400001)(921005)(122000001)(82960400001)(82950400001)(316002)(66446008)(64756008)(66476007)(66556008)(6636002)(66946007)(33656002)(76116006)(38100700002)(4326008)(2906002)(41300700001)(38070700005)(4744005)(54906003)(55016003)(10290500003)(110136005)(86362001)(478600001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bqduFNGxh+S29FNmFYUASAvKgrnqMgOU3sXUMfE3bOuA3v/WFgHikYIAKk1G?=
 =?us-ascii?Q?IfaUmjgC4Am3f60u8zFU9VJQXyh+5xBuFFeMYcIntTQUxitafcztHz2c+K5Q?=
 =?us-ascii?Q?9sbmtP+jKgQxVauSNjXcRZrj4xeUyA4pNOXfpyg8cTnAyXwqjq2bnZHvBtaL?=
 =?us-ascii?Q?004UCAnef+rnpx8d4BbI5ca/o3ox61RZ0gTWfqyyiRdo662jnq9XO/gg0ELW?=
 =?us-ascii?Q?NDF+xYmo/Vy4mztsE/XawACHQDt+dRGXzYU8mRYW+m/zucKw9AEPFGx46zJS?=
 =?us-ascii?Q?bg4265dctHA7VD86Bqgfiwni6L6jM/DireqlgmXi61AyA97B9WvCTv4L116l?=
 =?us-ascii?Q?UiBWHIbfaF0yPcinXdd4UWPTj6gwud4Q/Pypc6SZLJf9Re9UWS/Ssg/ZOu6O?=
 =?us-ascii?Q?j5Qey7NHU3IXxYKTAKsvLdsIT0QIBkww5Vu1zs6zCDnpY8ogBkBX5hV5QfbW?=
 =?us-ascii?Q?CsO8Mc2lS6jsXvCr42RSy87kTbkY/0akWr5WTPVqkYAoi1725Go0nBtciylE?=
 =?us-ascii?Q?vvnXjNRjwVICTynvhN+5PRYRKPe43tMcJaPpM+KUsumOezD+ufOEMg/eNcXD?=
 =?us-ascii?Q?IFr0BwgEue+j5fOj4WjwzE1pRLFOFrT6ab5D1yOgkEin1DmiqPJUZH5lhf81?=
 =?us-ascii?Q?c2TtgnawU/9tgjEmFYe3DFW4fiB8ZXXpNF3QvtdIo4M//FhTBoUDi9ZegfvH?=
 =?us-ascii?Q?k7pYodah2GjO1mMuZj+m7rZlcntVcSblOQAVwk7LEHzLj7TdXLcZ1pWeF20A?=
 =?us-ascii?Q?UeKkdejBAPqcEU35iQab5dxApdoGWEPDh7Pky7pbT7MmRqBFGrCMVzr76+fX?=
 =?us-ascii?Q?dcCwz1FQYWNfwuYqgmOjQWTw4l/4kEwR0SmnM8RFvyRqRuJHk7yJlwQME5eB?=
 =?us-ascii?Q?0WfQBnAndPW0M25wUriLQ+yIdKe+YViIW6q8IvvlY9fXmNnYvPj0KTF+Jn+B?=
 =?us-ascii?Q?OtEoJfmR1olC+3TwOPFacS2t+SWFWedU2GRdc81rQVhldwLM4bX9mUUxY6l7?=
 =?us-ascii?Q?B1xFC3auGO0yuy50D6KkQjWunvqzyZHPsv2Trecd5njcjHzdWD3Y8fMecOt3?=
 =?us-ascii?Q?zMtsPz3NgwuKA4tIKTW7A79O/AVF3rDE7ijw8QJjtsJAMWy9PqPLp5fryaLb?=
 =?us-ascii?Q?Nddq/tQFWJQgYhZZ5KYVnSgc85IvVEu7nwzfeuIx4eMgpyfEVPrUtRl4voPL?=
 =?us-ascii?Q?ncRjPWrXYcLZghDf7pOxFUvNn8QendGtGMEfnF+Z2I0vq7exMwCwimF6J+eJ?=
 =?us-ascii?Q?3SQanoco7kL40t1yqn+VBznv+kBKpn8RcqQjuOS+L+mgh4jf0K/AwWYq+oWe?=
 =?us-ascii?Q?LBoekK/W0LuhD3eToeVR4s+n96TjBLPCXfkkQU+bgOPrnpOPtMGdxiWqK2Q+?=
 =?us-ascii?Q?JCZsnTZ56RKdwfCo51JMFA/mxxIwKz+ELUYfiJjiNIBIw7rvlxUjVrouaKb8?=
 =?us-ascii?Q?h0470NSkvrIHYVIh+HPWYkXQrIWcG99+P75UOa0EeEyapD0hIDBoizTZNx4D?=
 =?us-ascii?Q?qrcLSM8kjymTEjfnEkg/CzpYirzqnXLNLbCSXzRP03Z4yWO7Q/jKdpU2YfDr?=
 =?us-ascii?Q?RVsuJ2WIxmXXkShlqs6xsnr+e9Q3e9gnrf0ZoZgpEjr+P8k6Cz5QHhtMQEf6?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c35e10-98a7-4281-7149-08db831bdd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 21:06:30.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBu5/LBM+hxFy72PnhtCfSUSm5OA2fv5GAe/GKqdIJe+whPLfjnmZQZBBacr6HSLJhLTMYx5IK8KKUrysDqTIcTEifVyT6N7y6+zHeraqV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: huzhi001@208suo.com <huzhi001@208suo.com> Sent: Wednesday, July 12, 2=
023 4:23 AM
>=20
> The following checkpatch warnings are removed:
> WARNING: Use #include <linux/io.h> instead of <asm/io.h>

The "Subject:" of the patch should probably start with "x86/hyperv",
not "clocksource".  Usually I look back at the commit history of a
particular file and try to be consistent with the Subject: prefix that
has been used in the past.  "x86/hyperv" is typical for this
include file.

Other than that,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> Signed-off-by: ZhiHu <huzhi001@208suo.com>
> ---
>   arch/x86/include/asm/mshyperv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h
> index 88d9ef98e087..fa83d88e4c99 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -5,7 +5,7 @@
>   #include <linux/types.h>
>   #include <linux/nmi.h>
>   #include <linux/msi.h>
> -#include <asm/io.h>
> +#include <linux/io.h>
>   #include <asm/hyperv-tlfs.h>
>   #include <asm/nospec-branch.h>
>   #include <asm/paravirt.h>
