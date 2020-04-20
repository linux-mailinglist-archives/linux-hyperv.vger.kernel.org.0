Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273431B11E9
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2020 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDTQlJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Apr 2020 12:41:09 -0400
Received: from mail-eopbgr1300122.outbound.protection.outlook.com ([40.107.130.122]:34400
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbgDTQlG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Apr 2020 12:41:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQfX9tW6KmL7CGvGYqo5gtD+fQoMnvDfdADGsa9vZhdAXQVUhiTdQeGD4zSGQBDn6JU9ie9uxnO3cK+76bNRPpoio/glI2nH6gUIqSez8dSJH23Nx75T63ZtKofU7eKw2ZlTZ1FWeG8hvuZjxwmhPtI/8EBB5Xz3bgLKf3+Abahn4lsCvdVOipmEvIIPzU69cXPBgfaIrnDCCxb/8r75uSyXbvfslP39uWJ/F8AF5kGUQsFfb6Aah8LZwWw8s1htnpIQOJqfuLt28Hkme+JdDmuGCruKrzLtFQ/43FG6Gz7lmNP2FETSlA0dVjuqIO/+HtVIqSn19T0Q1Not3pZZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj425DsWvodYJiPpBCxYf5VlUoVkfBWF89XmSQ8wYNc=;
 b=IMuzwxWLRglLmSIZpwwW3VMxbAd+MUv0/zLewsBLjm/AONrR7Q/MIl6aNRmq3L+uqERKHXeDWh07BtCvNubmLLbl+kp0Bl3AbKKWagRsNhHjNiAz9kGnpycA0saLEJjkutrNne36vX8V0u5KcHQodox3V+mszYFbOCWLW0sqpv9sB9QDae6xKOZNiCqJyQDlFiQpxPL2KjXYqlUvAoH8h8hQD03+A8lAPwLF+QDUGTBOQbb1or7qOjOExcoeOZ/8sBr3V2IX/sZd7WyVyQfomhlGlNRE2RkQ7gdCNXhVn6RIsVwk+7qyi7afdsR6ICXS1GollOc1l4vLkuRVjl2E6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj425DsWvodYJiPpBCxYf5VlUoVkfBWF89XmSQ8wYNc=;
 b=ceif5E5erSxfE5/2l9WWl1/MZO5ZnBHGrLx6jpr5LRva65oqBKKFigp/1dUgmIsM7qHzsPlMhbNuYUkT0prfB6jNm8ZQapqFTUxaA/j3gsb25QKBGJ8vCtm3C+ERgav65iVD07DBfCCvdVRpRxJlVwQzYHyTPdfKr22YbFugW20=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0115.APCP153.PROD.OUTLOOK.COM (2603:1096:203:19::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Mon, 20 Apr
 2020 16:40:55 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.001; Mon, 20 Apr 2020
 16:40:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Thread-Topic: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Thread-Index: AQHWFRKUfBcacZSsfESBcN86F1My4aiB7qAAgABK3nA=
Date:   Mon, 20 Apr 2020 16:40:54 +0000
Message-ID: <HK0P153MB027347CE9D0C35A1C53B19F6BFD40@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
 <20200417110007.uzfo6musx2x2suw7@debian>
 <HK0P153MB0273A04F0585524883C46B0FBFD90@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200420120822.4bncj2iwgqbpoxei@debian>
In-Reply-To: <20200420120822.4bncj2iwgqbpoxei@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-20T16:40:50.7568635Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ede3ca55-cff0-4120-b2a0-d6d1ef9813cb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:8ad:e9e1:6b1b:63b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af748047-704d-4f23-626b-08d7e54998af
x-ms-traffictypediagnostic: HK0P153MB0115:|HK0P153MB0115:|HK0P153MB0115:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01150C8A5B47879297C1A22EBFD40@HK0P153MB0115.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(9686003)(4744005)(6916009)(81156014)(478600001)(55016002)(71200400001)(8990500004)(10290500003)(15650500001)(86362001)(64756008)(66556008)(66476007)(66946007)(6506007)(8936002)(66446008)(7696005)(33656002)(186003)(54906003)(52536014)(76116006)(316002)(5660300002)(82960400001)(2906002)(4326008)(8676002)(82950400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfTTrTcIdwod2EtRGi1WYsYXRZKbmcLHqILumZ11yqvEZVl03B4OXN3TYRSGyRaECKXux+lzFWquiKJapduAQW/q4GN5yaDEKcNbMBcVVVxbS0/5q32yzc8P9kteiVlg1CX5CLaXVLEtrWj+N3HHdFZ8zpXIoAjKH8xXYNtykMQtTMiIv+4BHtpNo11vBgRRmUEru6X7V+tft1EEWDJzDjTocKTnSJzdC8t6+0ANabsw2g2hp6SfWljmu8I5BIuTlOq2Z7xmMli2JDkQNFdXdOe32sOPfXXggmYZyi2uSsVCK+5cm8oK3rVpgFNEv8bLNCDUXSUs96X5FwHY/Ex8RD7eZ8jZeeBUC55uSN62HBfy6+PMaDZNjnhNyxmv8Z/3lpje/0GEZhUvz/jlsHxUDjP6ca4g9muoHxRBJ0+R8Ny+z1pvjTVoCeH9zhsfeP/N
x-ms-exchange-antispam-messagedata: rshdaiudfT0+AOFZU4Cbf4xRTDG4JjQZJYvtPW8sfNxAlwZYCdCCM9ag2SQcCles6qjlgic9VCVg8f1gTm41jLRNkaLnAHjcVJayItqlQ5WFuq7RWHT8+NaqeGZ8j9uoQ2J0Jkms/HPbraK9/4E1AJ/mIpc+p5yzrRlfwq/6AV+L4uP4RHmzvRmLywMgAu6vlqgS7kjIayvzcUIOaHgP52Et/iCH0wbKQYDf5k1Rn6YbazWc3WOeGhEGaNKUE/NM9grhV9fUk0G1txd/5kIPIMnJP3W7SohHL+tNuawtNiDELS6P7wDWDs0RONihKDctmbNf0740yNZDJkcjxh8Pbx2sEGj7maewoiSNebTvfjm/rOehMOQWOOP4tsZZF2OE3CIiGj4rkXi7990mCOwVbctlkTuvs46/Fe4a7WdAV1154Hkscr+np8/sqYYTbhLdhE7OcX0hQrr9MpaNnQfGnINboelfSoCYo6IuyPvQL/s1g7gQIAa7NYMqV3NISHyHgJi9GwX3ceAD7GlZjuMebVKzXcRZ7Ry9IzN8jp5id2MsliRVRBSvlORN8vCyeD8PAjhtl99EGbtdcDEZrZaHPL1Ih0cwvEWJ+t3jNISv6gDOEJUKJAOCfXfSAGw/m+GbhIDx+Upfp4QUw6NG1cUSgnnZg7JtdOQjkDfyzT8KqW3sogryUtL+oZeuhncOyMOTBKK38EOL41ze3eH4uBz1mlUKsSumzgYdOFGn/ScrblPaP7IJjig9G9asEFuh2myCPW+bgpgBR4M1Y7fhERL4DaQaoo8hrpe+C+NVn8VNu7RIo5LUDjI74ucOPfbt/cqOCl8+qObsXcOF0Un3P0ihyaEHoYMcSjZjbjwcwZHv/EI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af748047-704d-4f23-626b-08d7e54998af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 16:40:54.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36C6ZxQ5nok7QRiBXOFNPZm/Gpr8EhCt1dOxvocr9+wvzkpcbc0WVgNhDcrxSMYuLM0eYL67WFMUmmuEy7zORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0115
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Monday, April 20, 2020 5:08 AM
>=20
> I would suggest make this clear in the commit message to not give the
> impression that Hyper-V has this weird behaviour of corrupting guest
> memory for no reason.
>=20
> We can replace the paragraph starting with "The issue is: ..." with:
>=20
> ---
> Linux needs to update Hyper-V the correct VP assist page to prevent
> Hyper-V from writing to a stale page, which causes guest memory
> corruption.  The memory corruption may have caused some of the hangs and
> triple faults we saw during non-boot CPUs resume.
> ---
> This What do you think?

This version is much better. I'll use it. Thanks, Wei!

I'll post a v2 with the updated comments. I'll document Vitaly's concern ab=
out
nested virtualization in the comment.
=20
Thanks,
-- Dexuan
