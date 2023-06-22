Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A862F73A791
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 19:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFVRqW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVRqV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 13:46:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D0B1BD6;
        Thu, 22 Jun 2023 10:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StRgRHkMriPAXA0NNm5vIDjRIqDR03xo5853GFGkXOmKUkf2M7U2v37eoyC0bn1jz6F1h8cflKy3+VaKb6OjseISYqWhCFgbqk6S7B65/8iacEHY3p1HRS35Ccltc27MpiT4HM95kKpd1CA0pIh2FQcGudqv+rUNdBNnXWebFwv/Y5hfamS51loIwozQoBoZazf8PzojgNk5xVuupzsQ/KNxU4k/cWL9yBkxNuQi1RbGUEHYa1clF+EyUPgGKSO6+CYrZCCiOhmjmegkLMlQOE/R3i/ecyZug53a73htzjIYfIjz3zhK+Zp3SejYCSUoSSQds2lWP6VZ4tYUDw1maA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqvo/GVH8vdic1vy93Ge4SPbSYXgtcuyM9HL2/P1yGE=;
 b=AuKPB9gv8YkDH2wQQoRFzO9KpaJCWJ7MU4Ji0ERvrGZhIg5yssHLAz01pCZ9FHLffm3c/aoxe42aI1VzduVpMUDY3zjouqUVpXaEPBvg7Jcnc7BqLj2xxapUCUBimSTqyDvoUhr0sKiKe4PLB14QM56JK62GRtrnHQxOAqPN3IO0NpfYGou/nUIF8Jk85anZ309wy/0xlyn8eHHFrj+wWs+0yadfjtK8QS79mzh9dhoA5DKV10SGXYEWsm2wCm/eySB2go8vbozUOkMHyS1654YOl7G1C5SHMYLT/9bkId1wUs3VjWZ2bwMGbHFUcz5mNerqOvA4Uys53AJv06jXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqvo/GVH8vdic1vy93Ge4SPbSYXgtcuyM9HL2/P1yGE=;
 b=AV5oPQMDR30qI2h3yofHGJA/c//vMEazrumB8KuYjMaMkYwj5zCD0VPtQw35v9fNZtTXFY5z+96oxbAG2Fuq3ZhtRx6YONIJ1SuRjAjya93F9UjGL+bdnTH31lHMBBZfr2pY+Fk873Uv1s1NKL2t1TarcKBxt5g2VyycvX6oaI0=
Received: from SEZP153MB0742.APCP153.PROD.OUTLOOK.COM (2603:1096:101:94::13)
 by KL1P15301MB0418.APCP153.PROD.OUTLOOK.COM (2603:1096:820:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9; Thu, 22 Jun
 2023 17:46:15 +0000
Received: from SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
 ([fe80::6260:f346:f62c:1eec]) by SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
 ([fe80::6260:f346:f62c:1eec%7]) with mapi id 15.20.6544.008; Thu, 22 Jun 2023
 17:46:15 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Thread-Index: AQHZnwV0dJHFjLU8M0ikMK1jJEcj8a+XJFQA
Date:   Thu, 22 Jun 2023 17:46:14 +0000
Message-ID: <SEZP153MB074232C9FA0289579BFDDC2FBE22A@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
 <2023061430-facedown-getting-d9f7@gregkh>
In-Reply-To: <2023061430-facedown-getting-d9f7@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf8782aa-bcba-4efc-823b-91cab283ce22;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-22T17:44:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZP153MB0742:EE_|KL1P15301MB0418:EE_
x-ms-office365-filtering-correlation-id: c1a08cd4-90ca-4073-1339-08db7348935e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3edBpO7Evw6V5A/qB2sHZBa99lNbaARv1So0yrxknR2AoO43KiNtBDt0YGQeZidGHAfML78CYj5XhaB3EOHBxqOeIyM8gHY77Dipck0UeXDuaXJaBEXeiLKmj3TqvYvvqKQnwItJX5CyhCLSxVZnZ+1nB1mSoHWT/gK0S9c28oG2c+2WxTFeMrr6LxYE11XgB+3nJkzwyADorssipIL6ts0oX0yONryy2u+RyElWD3pNYbPHpMbaJrueXo3d+EMQdmbTCh9W6CNiZPy1SipmwAGkeDSj9EpbtHDaq8imF8OjqFwTbhi+XE4uNN8UDcxHkSloDG1Qz2hEMcYUU0wE25oN3If0wiFEKinDIlzhXSaHmojRZUbxTUD7FxtLEHkqpzum1vBDFUQ0C4vmiME6MZcgIztVfy/fHJoMNBBeeFW9G4nVBL9CpN3RqwAiHbgyW0f77ipOMa18ZFfrdmz9BurgkOHGgoK6dpacWbYnaVRleEvwVXpN9/f4IfGmqcMlwBARHHt3aYhYGJSw7sxoVERvBhWy1Avm9uuq7e2Dk4FZ4vdMFgQG1iFLtqkxarvK9A/sKNzUabE8O2Vnj4RRe56pcpZAZIxSN54fFpCHDBpCv1fG/Nx+D2qQxuHq02a/ruxpGHZjHUFWYvrb1DHz2NYZb0/sL+NOXFGO7I+iY9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZP153MB0742.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(4326008)(2906002)(478600001)(10290500003)(38070700005)(54906003)(8990500004)(110136005)(86362001)(7696005)(316002)(82960400001)(122000001)(71200400001)(82950400001)(41300700001)(76116006)(38100700002)(33656002)(83380400001)(66946007)(55016003)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(6506007)(186003)(52536014)(5660300002)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIht7kP04WrfPk/4cQ9gd4GuDCknnsbWyIX8ImRerWRUOP9LKLrxeb76l/1z?=
 =?us-ascii?Q?Ax2ejLAVO+Es/86mTigc2n9M50+PcXdCr2Dy8mY9tQ8RWtJ4sPP++383St4d?=
 =?us-ascii?Q?4j/Bc/Oigru9CrTcHOphAtDQQpZxZbCygkg4TGBwACGMcd+APHIh2vUpBWZ8?=
 =?us-ascii?Q?ANomfPZqCClCj7ZK5yZh1NcydUNZ5MLOgNfrMu6Sj2rvHYC3y3l02O0yjU0I?=
 =?us-ascii?Q?ld+2wVE39VUKJTKGVGicKxwSGJXCKCgmjohTCof3Ili/l6jDhmNn4oRX+N2Z?=
 =?us-ascii?Q?DNrL2nECFq+6yfA9IifdICZ30XYVICxl6X9bF82OCuRQ5pPaA7r0JhzBgtpH?=
 =?us-ascii?Q?46AjkogRZCDk+nrYYfh61t3R89dSCuKvE8UqcZconRtCduLrON2ai2i0MDcV?=
 =?us-ascii?Q?EqRbVx+GeayDdkgxE8jMdWSNrKwlmqHSVaafWZ6znTrfPGKsTiFhdUNWdKg1?=
 =?us-ascii?Q?pUefRPIFhioMp/YtJ8hkZJ3zA0NiSBHiBHx0O+znXETtXk27wwAAb/7TXPhb?=
 =?us-ascii?Q?TWuXDs8fGvXqtK7UNvjWNGXW/R2WSQLxFWxNAlfyURG3mnpNMRtVcvBitUHy?=
 =?us-ascii?Q?bwUfdBSFteFvfMMHs3ayixMcl8K/wFGIkJ8K2+1mS/iVvfmJUMFk08InuQPu?=
 =?us-ascii?Q?AD1seUHjTnRBXtyB2VbTJivVJ1dqQdMKhkk7E+O3iKKQSBlf8TMFibRnkUd+?=
 =?us-ascii?Q?tEju9B1aTqJ01VkSpxaok8ecJrG0ItUQ2FvediAnTi2KI1HhmdMA7s2LOwoq?=
 =?us-ascii?Q?uMpe9IjzKPmUlQvYu+iYnw/fUKAM7J6tderD6W/r58QQz7ER7432+8YrA0u9?=
 =?us-ascii?Q?zT6eGDwqzOnxLcLOTd84hdhexsEOPThDcpJiZGywI6m/AkRlO6S7Q+r4Xett?=
 =?us-ascii?Q?ShbVsA8+ySSQ5vMPJ9L5XHNu3CAOxeAknqPeIyNUiC7nrc3P2sDrfNJuCJMq?=
 =?us-ascii?Q?bedoLZnQTC0ybksw5cj74etdTfvbqh+214ynf0VDVCUDeh30aaeHsZXY5P+v?=
 =?us-ascii?Q?mzP5vcEEx6Zc1FP5zA7D6N6XJqQWZA88O58Ty5LU4FoqlhJmqlIywBXmwa8N?=
 =?us-ascii?Q?kiq16y/ISyiLWatsIayzL5zhX1U2hSpCbzij7wTy/eGBmrIpEu9JkdEapClU?=
 =?us-ascii?Q?+WhWKM+/wBDoJp01EES90TBQTBoVlDChLT/YIa5dgA/uUVB9Q40LHY9LwWYX?=
 =?us-ascii?Q?p7UlllgBxr7GqYz6iaezYZvI+c1913Vo99ckxi8SnPvuRPBH+PM3Kw0sYlgC?=
 =?us-ascii?Q?dfMBM3rfkcLyEiTZdT6HuO5ihSny47iAaKwNVxYz4hipv1pTw0+L4g4dFw2g?=
 =?us-ascii?Q?iUnn24HD9Qe3EOAcAfdJ23HlX5Owepm3Aqn/Uh4Tm+4oDwZvCWPTaX0dM+53?=
 =?us-ascii?Q?PsDgqh+MM+aIbPE1Rg4uTj8qD/VyBIQ6wG106mDbKq29fgviF9BOqkkB+WI3?=
 =?us-ascii?Q?WqUbuARLe1ortT44zSUtlAOB/NaktQq8byBo02u4PBSFnNV4cwL6kaXeHvW9?=
 =?us-ascii?Q?vtAHQx1XQOghd5wBjSyB8R/7Rk/e91aOofh0tgmbAnoVAo6v7Mgk5LNZSm+y?=
 =?us-ascii?Q?blriTfQQvOnIl/GrELFgEufXHn7ldHFtJ6cWXcHE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a08cd4-90ca-4073-1339-08db7348935e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:46:14.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBHYVl4E1vgtE+vjJhWx65X8VXZz35KNkeRbrv9E5AVPS+RpyyH637yfFdv8GK9qBhrwTOSMI0WbDhPl9mRnjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 15, 2023 2:46 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> corbet@lwn.net; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.or=
g;
> linux-doc@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
>=20
> On Wed, Jun 14, 2023 at 11:15:09AM -0700, Saurabh Sengar wrote:
> > Common userspace interface for read/write from VMBus ringbuffer.
> > This implementation is open for use by any userspace driver or
> > application seeking direct control over VMBus ring buffers.
> > A significant  part of this code is borrowed from DPDK.
>=20
> "  "?
>=20
> Anyway, this does not explain what this is at all.
>=20
> And if you "borrowed" it from DPDK, that feels odd, are you sure you are
> allowed to do so?

Yes, we have confirmed this with our legal team, as the previous code is
covered under an appropriate open-source license, we are fine to reuse it h=
ere.

- Saurabh

