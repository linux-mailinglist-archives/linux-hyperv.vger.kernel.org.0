Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3BFB9CE7
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Sep 2019 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437193AbfIUH1W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 Sep 2019 03:27:22 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:43776
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbfIUH1W (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 Sep 2019 03:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXVs3AHUd3eRwR2om32k9n11ESRSdw2JS+oisd4Q8ceGU8ulmbniXcqiyQM6zFniLLsVp9SwUG29Cy4aiHib/yGXTOd+Oa5R0cVqL8l5mOLOZlg4nRVUnoSxer/9eJXg06nwvNk8P1VbRpq4CdydndL8XBDv76ixOuG/y89oxx3k6SVUh7P1VcPMdYuYN/BPM00/KJ8KXXuRHaC7U1u2KvIv9NWyeyAM+NRfeoxGwxCD9+f2Y2SlhvcnvoEznA9JWJi0c39DepAJ5CpyTttpEAho75EZNQyggpnoH2U+HBoR/1jeyVtBgvtbOffFYRkXUTfa1vvH5NIdAeKLY33j3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHcQihBaV5na7aa/HslfdoAawhPsOby+8Gp1DHMU658=;
 b=EWfe9rZX7lF+aG51Ij2q847RRMR76E+dsF4AgCs4tdMuCNDEUJ9wohT5wUcryXYlFzdyQd5eldwGRJ0YXGVt8ye16woXP6V2TO/3nj5Crcu1F2PcEO2RmrSE+ehI/CdwPnEQswL7MD8DMk6e240GgfmbsRDE/m6xjn38hjApS9xDkjOaxF9p42omjfAODG9fBZgHr3o1KvfZeTp9SHOh3dXSe84yL+vdFCnD+tZdqwv32xyBkT9OXlo3F5nFUM1qAwGsyoRhZNvOvDQL4SvVs5GtX5Gy/SnMi0RFbfnLVk/aXVY7eLGVF5Z2SV/gb5ZO0kUAvAmLE9qm7hEUdIGZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHcQihBaV5na7aa/HslfdoAawhPsOby+8Gp1DHMU658=;
 b=fDIcgNEnKdStuXybpec0VCux9KzGE2ASP8Kp9HosSB7eAG6I4N8CX7jALYLxAFEV7tA/3RKYFBfCvKBa+oDRB5sZaSei6di2OownQ80DRv2G+HRBnNPF3ENpWqGHfBqOoFyhWkiOLKAGIPnvRwIiUbbZ5FfjH5d5sCYWvGLciSo=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0122.APCP153.PROD.OUTLOOK.COM (10.170.188.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Sat, 21 Sep 2019 07:26:35 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.011; Sat, 21 Sep 2019
 07:26:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/3] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH 1/3] hv_utils: Add the support of hibernation
Thread-Index: AQHVaYhA3nfAp6qkREmtH6p7KQYwRKcpxtlAgAQ8TICABIF7gIAAUgiAgALprxA=
Date:   Sat, 21 Sep 2019 07:26:34 +0000
Message-ID: <PU1P153MB0169062227FBE0A039EE4FCCBF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com>
 <1568245130-70712-2-git-send-email-decui@microsoft.com>
 <877e6dcvzj.fsf@vitty.brq.redhat.com>
 <PU1P153MB0169C6B4A78787930CC9ED4FBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <87pnk0bpe8.fsf@vitty.brq.redhat.com>
 <PU1P153MB01694ABFED7ADAE8B40A65F7BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <87ftksa8dg.fsf@vitty.brq.redhat.com>
In-Reply-To: <87ftksa8dg.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-21T07:26:33.2674328Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b2f6465d-851c-4170-b967-ddb6ce3769e6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:54b9:c9c3:20f2:72c9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 842f08ca-d3f0-4934-6c32-08d73e65089e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0122:|PU1P153MB0122:|PU1P153MB0122:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0122088E6C6D4D9D249D71A3BF8B0@PU1P153MB0122.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0167DB5752
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(66446008)(186003)(8676002)(14444005)(52536014)(76176011)(8990500004)(81156014)(99286004)(11346002)(81166006)(6916009)(10090500001)(7696005)(476003)(256004)(25786009)(86362001)(22452003)(54906003)(5660300002)(4326008)(6506007)(6116002)(316002)(8936002)(9686003)(33656002)(66556008)(76116006)(66946007)(66476007)(55016002)(446003)(478600001)(2906002)(102836004)(64756008)(14454004)(229853002)(486006)(71200400001)(71190400001)(6436002)(6246003)(305945005)(46003)(74316002)(7736002)(107886003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0122;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jC/ZgSUJy9nJMxHqrx2PpjgK8AYc+XBTmWSefmW2+MaJ+X9rW/ypb8/pRSgN2eJPmiowm7c2hiRb32lVnjkaK0uR36u0OA8X94ftusp8wo2o5FD0KXhaBWT4CKiQK2wWWaUpDYYTuY22Xa1nAPyykqP3YBIbd0fNrJsEmTdRft0VyX5xmtxUPHvdz//Fz2De0bGRtyECIL7Kfv8MZNcwTOU0r4kVf4ZoYv7E0As4H7vUjQz6gRCX6fz9dSB0acmGYNfsAitTTJWEptIiidbq0PCbzjtasSk2LYxx0c98ws+VmJ0qS7vTqtAI7qL9efligvezZnqQK3u4pMkpfupu8bqVsDoOpZSnvKJKoEziWk5LvD/DUGoceK0e4saRgPaF3AiqDIL0ONmDyf2NEIjAQorpW96F4ll6Hc//cjLyBbU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842f08ca-d3f0-4934-6c32-08d73e65089e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2019 07:26:34.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8yRhLUbZ+FmakY97HX6wfRPUGfSWe+AO+bAz61sB82TwYeKwpEzurzxvs0M45OKmWxtPqlnd95je2caW+bUhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0122
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, September 19, 2019 3:28 AM
>=20
> Dexuan Cui <decui@microsoft.com> writes:
>=20
> > BTW, for vss, maybe the VM should not hibernate if there is a backup
> > ongoing? -- if the file system is frozen by hv_vss_daemon, and the VM
> > hibernates, then when the VM resumes back, it's almost always true that
> > the VM won't receive the host's VSS_OP_THAW request, and the VM will
> > end up in an unusable state.
>=20
> Makes sense. Or, alternatively, can we postpone hibernation until after
> VSS_OP_THAW?
>=20
> Vitaly

It looks we should not postpone that, because:
1. When we're in util_suspend(), all the user space processes have been
frozen, so even if the VM receives the VSS_OP_THAW message form the host,
there is no chance for the hv_vss_daemon to handle it.=20

2. Between the window the host sends the VSS_OP_FREEZE message and the
VSS_OP_THAW mesasge, util_suspend() may jump in and close the channel,
and then the host will not send a VSS_OP_THAW.

3. The host doesn't guarantee how soon it sends the VSS_OP_THAW message,
though in practice IIRC the host *usually* sends the message soon. The
hibernation process has a watchdog of 120s set by dpm_watchdog_set(): if
dpm_suspend() (which calls util_probe()) can not finish in 120 seconds, the
hibernation will be aborted.

3 may not look like a strong reason, but generally speaking I'd like to avo=
id
an indeterminate dependency.

Thanks,
-- Dexuan
