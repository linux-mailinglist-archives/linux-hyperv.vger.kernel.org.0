Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875EA4AB432
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Feb 2022 07:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiBGFrI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Feb 2022 00:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiBGCmi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Feb 2022 21:42:38 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B555C061A73;
        Sun,  6 Feb 2022 18:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFAQ18UrOVkjVMkr/cvlxbPfMsxYiXGZ1ZmvZNKo/lYZFmBoyKfJfhJogQkT22x5sVSq5SNnLvOKbSDuUr2h3RZ5uYGby1GGy09XmDTbGVAjIpHHAb5TQvC1zilv5+5j+zwFf6BhsXW4nA28WbQGcgrks+o4B1VYaHa84hVXYYCnPrEqp0yMi/D4E3JXqIj+b5sLaZ6aiOcPRPP5gf+4iN/Ld3bebk3dFxaO9wyOK6FbCQoXAAKgxRVsF6nJpNVRzxHTa8vjaAGayYxmTLAd/Z7lh+t+D9ri2/RfFaRF68Z2ppjrz59Q/JXHB3ZNj5u12UF7szjl2+YKKsKZjG+MBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iohs5oZtvV7B1wqi5kZ6fTopYNBtrSepimV4xZTIu4w=;
 b=UzKngIiB0WRIJ2zHh0hBGN+3H3ti401Hzv3n0xZma5jNYceuNlN+yo7uVrD4BX5i7VOqk2oknzGHqA/o2OzYwenGAp75QW3iWendndsawSwVYgkaOBynapzBYK00V3JEdpEFq/tet6fBV9vvnHaePdfPFuas1IEeN/gMcC62aMBkCMuZKPgWohpnCOuaE1C2nJSYLZls7HmBzaK9I5rlXz9E0TDrtE0v5MLilZKi0lYM6VT5A+HepJPLcO5gU9jcizdDk80LIAWr2//WuXYGFLFQl9Nlut2SJrhgpDTl3X426fCBbsTagAbfSFKMhr578Ej5U9P/kX+iQQ39Ioa2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iohs5oZtvV7B1wqi5kZ6fTopYNBtrSepimV4xZTIu4w=;
 b=M+YuzCVov3HnSxBuZdJvGom1HJNvTJv4l2moSxCHupTG6d4M+Ko9bWesJnm5z+IBivaoLbTPlupaNp6edHg/x6ngCumJflWhjedCOUFvAgmXH2rWA8BVB/9QvDXqUp/xN0xyIPfvFEl+i5v0EcSWzQC2dcHje3WdS7kJ6M1Cdoc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM6PR21MB1403.namprd21.prod.outlook.com (2603:10b6:5:253::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.3; Mon, 7 Feb
 2022 02:42:31 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15%3]) with mapi id 15.20.4995.003; Mon, 7 Feb 2022
 02:42:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "vt@altlinux.org" <vt@altlinux.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)
Thread-Index: AQHYG5DvoksMe+hA4Ui5ELxT0CEypayHT3kAgAAQ5oA=
Date:   Mon, 7 Feb 2022 02:42:31 +0000
Message-ID: <MWHPR21MB1593B68BFCFC1AF8F39345ECD72C9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1644176216-12531-1-git-send-email-mikelley@microsoft.com>
 <YgB36FwuRaF85WQq@dev-arch.archlinux-ax161>
In-Reply-To: <YgB36FwuRaF85WQq@dev-arch.archlinux-ax161>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=979fb629-43d9-4044-85e9-1eef3664e1d9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-07T02:38:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 281c4ab0-26b7-4c60-a3f9-08d9e9e37d12
x-ms-traffictypediagnostic: DM6PR21MB1403:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB1403B96F5F10D3ABD635C9F4D72C9@DM6PR21MB1403.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xIKgwqWUtlMRSvS2411lIKQQcVN5Vujel6T68cWOkdS+ZDoubxDpU0ak7NkWAPk6uKJQ3JmeSJntu0s9lTkj7DxSOKYFAXwqAKxILrgOyqvtdO2r0TZZ5+uej9a7dAkqLBrJRQ58CF+0XuXmuL2DKyfaL1tgNjMwL6aOz92EDfhlUgpC9taNmOFYhX7NlSJvbB3zA+YRluAfUPo51K60tqjw/SnqxoHQ5sI+r608n6GsDpVKg86v9649NFYWYEatVJFi/rDJuBneXIylwbkqNKAOjLNiDztICi1xr5YfbHcrXXVOyAXoN9TLN09IXks6LzOBmYqMl+8szomOpS43JYYlDDVUu3vp3DVVJN49Sii9RUJ/h28Uy37Mz1tI4XsXzPkZJO3tnSs/YVyPljUX1SeiH5zt8ubR0gWcsoWjXaKmr2L8K40B87DrZKJkGrNGDJSDc0yC+D8zqDVHmZDtAhOKdPJFLizs8BfCOfnv6MWWxyZHehrhIFanbiS26yDnPh/m1y8vGddl5jiZPon2eHn6KQRgNClhpKK+Q5XxP/3+8RMFAsuwLYD82iBnLNM9AT9qHFb+K4delee6iCOgxiCauoFz2uk1wH1jQNNBcqA9P64Y+SeIrAV4pGOmTlBl+Plfco1gp62PH8WxVtiP7+QZWA1PVgmNG4tVxr5cwx2wKhpagSImNuEjX+y/bw61wtq+OrJHHub/3SV47Mz8tp4R42XwW5Y8I8syFQxy6nBnHAzeeVrkMUfQJbF54OUz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(66476007)(66556008)(5660300002)(8676002)(4326008)(508600001)(10290500003)(8936002)(66446008)(8990500004)(6506007)(7696005)(55016003)(33656002)(66946007)(76116006)(2906002)(316002)(86362001)(52536014)(64756008)(83380400001)(38100700002)(6916009)(54906003)(186003)(26005)(9686003)(122000001)(38070700005)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SFPTUWRRT4DBDHWAscw8VnNVrL8W5+hN9morpjOyrmNv9xhZGKg3KQLchNoK?=
 =?us-ascii?Q?fW/iXyTaN+JnBZr/XSk1BVoD2xn8S/0Z8KxmHP6ceufXj/+BoUdk+K5iBjGV?=
 =?us-ascii?Q?pd74GMy1QedY3a5nSF4Wj71/HA7KDlTwR8YVbrc4M9E+ib0+F7xkaE+ADHZl?=
 =?us-ascii?Q?2XiK+YkwrJm/YYdJJvjuRxml3KPBsU0dYDsjyAaOk4Vmyzmku8CjQxevNG0u?=
 =?us-ascii?Q?JcrKGvEWbC/NVUllXEnSJ8oDkg8fKnNG2EvQcH8ekaRB2zc/6yclQHd2C2w7?=
 =?us-ascii?Q?zKztiNAl4kducph0llXSH8nSqACHLG7wqh7PuBhJoJzkqsLjFIpBnbprmzX/?=
 =?us-ascii?Q?LgPxIAaBNhx79kKYtCAhVMuEgpAsazkMzI11XOUI+luCQJvjGnpP06tjt3MI?=
 =?us-ascii?Q?itFyo/FTfK+HloqkaeTEG3oO9q63stSf1/1907Ss8i3o+AG1aSAp4lFlmsCk?=
 =?us-ascii?Q?ezptkCKIubD5WBX2C85Om1ojfxxeIacHqZ0R8ITLPtor9SkANEzAHY8xj37H?=
 =?us-ascii?Q?EucJ6x3WYWufi9m29bqyrRsLJrgElXenqKMGwNPhginvI7Cojt6n9+VW5kdZ?=
 =?us-ascii?Q?1j5QYGdPnEWAmo7fRW4F8XDb2ALt0x6JDFWTjdA+iGinoxutiM5hsAkxJxaW?=
 =?us-ascii?Q?w7iVHuNBUo/fDKx6fPaaUpx+CeErTVJ0FaTGkzqGVO9nYEFqmXzhbWMitHEw?=
 =?us-ascii?Q?Mqx6k2lWq4j+3GZS5Bvkf8ywQLKNZgOHAK8fvhG3e5IvHXvU82VV3eXitkAu?=
 =?us-ascii?Q?i5Ip1KBJLwD9p5EUu7pbrPEaETW18OVRKJLPPsxrG4rSPuASfMjX5kDxS7IY?=
 =?us-ascii?Q?lAbAPcDqkCSc7hZTdLXTItbXl7jkExdUfZQd1B1dcsnWv7aWQ1Q0yRSmCqv/?=
 =?us-ascii?Q?4cIbB6d85qVU+OkCWfaAtX4j566LzOhIjKdbZa57ATc2QVogYgT45Ywr7H6j?=
 =?us-ascii?Q?zArxZ40Pc+vJP+f4cCn/j9LGeCJTU04I1GBf3j9KAu1JLwjjFNK0Vc2XjL1z?=
 =?us-ascii?Q?UmRVorz/LtUClGl5RTQMwHwkhCtLCbHIwxCbpW1Gcl9NCf0JVfZNHEZ+48MH?=
 =?us-ascii?Q?57LYikaJmOTJcRxupc7TwULTwJz6vvQzORSI1/oH4is4ikdT9+k09euLhVYO?=
 =?us-ascii?Q?fF5dKn8BtXLwD/6DYQWD9UrdxNKd+JcoFEOwacsG/IsU9P7dD9pXDsKMWd/H?=
 =?us-ascii?Q?AmCEuQbNzNZzfBUHJvcIAiQvoCmmnfFoXaAj77DUOM/U6tUGVIXz3pPIRG44?=
 =?us-ascii?Q?TbeuJZIxtA/FCc3AAPTqzic0Cf7jIpXQL5fVaxH9pR1v+OI7wZtbDQoKXimZ?=
 =?us-ascii?Q?dxpQzPKSuoVnTf4kgQIQOtFrE8BlniP1QJE7WwsY9khLCabEs17rzfPq0Caz?=
 =?us-ascii?Q?Fi9YLJzrUzfAECTjCMOGR8a92Nw1UnKJLNf3+MdbKLNufwHDG99+3ooD+9WI?=
 =?us-ascii?Q?a6BV0yJwOwqdQ0DKrAfmu41pNe9iSvqb635OPchedI0XBdd0pXhpcLM59TKX?=
 =?us-ascii?Q?HxJe6tvpbzJQnJ9uge//lofbCLnVGum7S78dDxX4ueVOnFwzLfRBiMZfHiw4?=
 =?us-ascii?Q?HHmNj0rNCHrn2G3iQu2wvSl14X9U/jB0t+wnVL/M9jbZJOjP07uV6iEJbL68?=
 =?us-ascii?Q?bhgiZ+D2P8sTNXRGX3588BuGmY0khhaLCTqn6NlW/4r4poOiYyVkxD/HraUU?=
 =?us-ascii?Q?203Wag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281c4ab0-26b7-4c60-a3f9-08d9e9e37d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 02:42:31.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXlKW4T1lKhJXowwY6qxOWj0A/X53EKPE/6mXJB/7LpnIX25vxg0Qbc+VkTb+gLm+WnlJGgM252gGV28rkaPPsjnMZ9AbA9E5bCt7CRfQyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1403
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org> Sent: Sunday, February 6, 2022 =
5:38 PM
>=20
> Hi Michael,
>=20
> On Sun, Feb 06, 2022 at 11:36:56AM -0800, Michael Kelley wrote:
> > Using DMA_BIT_MASK(64) as an initializer for a global variable
> > causes problems with Clang 12.0.1. The compiler doesn't understand
> > that value 64 is excluded from the shift at compile time, resulting
> > in a build error.
> >
> > While this is a compiler problem, avoid the issue by setting up
> > the dma_mask memory as part of struct hv_device, and initialize
> > it using dma_set_mask().
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Reported-by: Vitaly Chikunov <vt@altlinux.org>
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storv=
sc driver")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>=20
> Thanks a lot for working around this. I am hoping that this will be
> fixed in clang soon, as it is high priority on our list of issues to
> fix. Once it has been fixed, we should be able to undo this workaround
> in one way or another.

FWIW, the new code is as good a solution as the old code.  The new code
also follows some existing patterns, such as with struct platform_device.
As such, I don't think of this as a workaround that needs to be undone
in the future.

Michael

>=20
> I can confirm the warning is resolved, which will allow us to build
> ARCH=3Darm64 and ARCH=3Dx86_64 allmodconfig with -Werror on mainline with
> clang once another fix [1] is merged.
>=20
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>=20
