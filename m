Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDBBE5E7
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2019 21:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfIYTx1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 15:53:27 -0400
Received: from mail-eopbgr1300105.outbound.protection.outlook.com ([40.107.130.105]:6127
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbfIYTx1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 15:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBKb8AGAFjYLKYeVaLLKdYGYi/HR0SCc8XaAadhjw9IAj44QaeaG6KJV2k2vHSmct9pqJewMvT4y5F8amdBEBiGd7PEYCmFXa4XtzyOOSM1+APzHgg+SJmWJGnjxvRHd4l3abxgbH5rNnmkX44nKIUU8d+mnun4SB+wSlTm4AN87f3ffvey0yvREA0ZxaHUaebWuBtkOISU6BRUd96qkdAnXL1POZdtToEAsihTk8pm6aeeHsEZvxLSVztOaIZo7b+RoJfjtKKCQ8m+GS9AGRKZURAk6pHX2b8ZhpKI0u9QnVjTxZYT0zSt5EBELjzA/D/yfmbgD6t2R0Vx9FLN/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsLyvRCIbr02SR0jA0Z6oucEcCmJd+qByJtPTdbYKnA=;
 b=IXmNxL7/DfyrprGoVpd2NECrOVJCx8DZDvfl2lxjR4SzTaL9Ob1eNkiEQI/SPVRTvu4uDvWC2QTQ14C5COJWvUzfpbNFPMa8eEHoFXvk9hl2rwjfq/NdeI+20upFil29Yr5/Dq6Oq+t1DXK16IAfdecOr1OEZqiuIczT+5tRs498XkaL31LpnO43Jj9iJCAZ9wsV2fAgsa6w3dsH/0bWzmNtMso7VXj5IUwPEypBU5OQHLPWDVnM21r7cadXRH+cWg0IVRGUa5ojAU2EgQ7sFZAJjEODEnukRuXKu2Q3hOstq0DWXbQeFL6p1rbencmGjMERZe0C9GZkl6PSGwNZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsLyvRCIbr02SR0jA0Z6oucEcCmJd+qByJtPTdbYKnA=;
 b=Fp0DnKSpL9001uyJ/D0Or+z92f+A1+jrYrA9NpN8uLx6t2FJWWv/itrQNyA73S85bnzlcfXqk2WeshCR8YuGsGYDcc4vzA8danxjUrsO7M7o5Pkps5Ly3DzvchOFdZ9jveo4bdMAInxYoIhv+s9sJdW9+3ZDED4A66/Rwvr62CM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.5; Wed, 25 Sep 2019 19:53:22 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 19:53:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Topic: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Index: AQHVaPmqZINIgyUXxE2R4/KRfEe4oqc84yhw
Date:   Wed, 25 Sep 2019 19:53:22 +0000
Message-ID: <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568244952-66716-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-25T19:53:20.7582067Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e0f9b41-cdce-46c7-90ec-b90b750b9b58;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7074dc-b0b4-40a0-6ecc-08d741f205bb
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0139:|PU1P153MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01394463403081EFF58890D2BF870@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(7696005)(102836004)(2906002)(76176011)(5660300002)(476003)(316002)(25786009)(9686003)(55016002)(6636002)(33656002)(486006)(8990500004)(52536014)(76116006)(1511001)(14444005)(86362001)(305945005)(6116002)(66946007)(256004)(99286004)(74316002)(6246003)(6436002)(186003)(4744005)(6506007)(66556008)(81166006)(10090500001)(64756008)(66476007)(66446008)(71200400001)(71190400001)(446003)(11346002)(10290500003)(478600001)(2201001)(22452003)(8936002)(46003)(110136005)(8676002)(14454004)(229853002)(2501003)(81156014)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0X29lQ6kjroAywh1Gz3L6tlzc04aEJwnh8lRCRCN0nkifdiSrGQMGjyG790wZJBbVypz6ba/xLARvqTZzh/0UXlIxAvPwxUvihZ95+duh4HyN8kjQPAr9MBaAdtTZ7LHojwwdJQcCYWzWwryDgHGYS3F739jobghqCA1BVL/o0D/VPmks1YWaPt+2HTe56DG9PvJFiPvZRVV4JP+wC9MTPZfRKP5pGGzEO7VcNpLq/im+fTWs0d5kMBKLJMs+hifYCiFyHGrcu6q9ySiHJIMMn04GBJ0WWGd6UIPHxI92vYaxaHeOeKKTSCRkUNDFvXhowsqPCbRpHmli5NAcQJkzevrXmWKg9KHkP9YEmqar/b5oyiWf6sQaG7CoQJtQuWxDxGLDmDhap2p72yZ9H5WAzrFMvDYj1kBsvjvrhIJdkw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7074dc-b0b4-40a0-6ecc-08d741f205bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:53:22.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlSTyxO+AFutCGkQPbVV7u66V2dfaVtfff2UujYm+of7psbxv0ZA0RUkN/a3MiC+ZldW5bkrj/Xi7LN4cY22iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, September 11, 2019 4:36 PM
>=20
> We need mousevsc_pm_notify() to make sure the pm_wakeup_hard_event()
> call
> does not prevent the system from entering hibernation: the hibernation
> is a relatively long process, which can be aborted by the call
> pm_wakeup_hard_event(), which is invoked upon mouse events.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This patch is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
> Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin=
's
> Hyper-V tree's hyperv-next branch [ ... snipped ...]
>=20
> I request this patch should go through Sasha's tree rather than the
> input subsystem's tree.
>=20
> Hi Jiri, Benjamin, can you please Ack?

Hi Jiri, Benjamin,
Can you please take a look at the patch?

Thanks,
-- Dexuan
