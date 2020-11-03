Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3162A3A30
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Nov 2020 03:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKCCEj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Nov 2020 21:04:39 -0500
Received: from mail-bn8nam11on2093.outbound.protection.outlook.com ([40.107.236.93]:35200
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbgKCCEi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Nov 2020 21:04:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTs58W7FOzHSTttkXCu6/bnR2ofiaa0LCg1yB5BXRCVJdhuV7O5CF2ZoC5+oabPQEwHlT87ZkdpqAfUQUsUyw/kiSGEsw0QOETaam0UAIpV7RMdicqeRHFa4rq07KYO1KA4OIw3SXibGD3a8uBJrKxJyoyfutSxYtSIy1pMn8peeIDP2l58goCqNmu6UUo2JkCKwy1z9h1/92m6TOS6agT8Rf2mmVgHYTa7WEdZYMvJAV9NrDT783QeNgdn9RcvXUuSEm33RjvDEX4ZXA4Z5iL2O8zeV7YsORVcHtHuUGwgFbja3wuJDC49/J/WqoYB4jB9y9T9vhaJtrOGPhQUATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVN9jrTBn8mUsbYJ+gpxYd7R42nGEbI1JeylcClYQQ0=;
 b=Zb2IUUlzPLHIVlEsyDJwsCAk92w332Rc2YbI6cSu6zHrAfsXELfTGSeElOOE9+9YzDoNlwDR+PMPPCvTpa3yHQM1gpg72iPqmjtIN2bTaAQ+9ObRDP3U4IUFyQcbWGtBiijxWgf0Snjq38BZVVgf7NmSQEBVLk4D2MgoEa6MKvTBNeH/01+FvrRdTYp7KgtvS4IEUCeYxZUMLhxK46/IrwvUfduSYUkgM08U2lyX7Or0Uw/yYnWyvrTtsYGr/ATrJiRfRliVLnpmXOVQ8Jp8SSWfASuGHYXVQHCQ0ZAUS/yOo1D5PIeclxfeXshwb9fCmsu/nOlOEYujJLld6Iuysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVN9jrTBn8mUsbYJ+gpxYd7R42nGEbI1JeylcClYQQ0=;
 b=LYK5Yu5ffoffp3JAuDBjxFePK9BT6uZLwcerANnwqpVePGhQNE2cRVrAzQGOQUu7/YEDXpsVqFAIbfHUJ5syAEY8X7Cal4mB6xJ5e6DJmK8yOu8IDEFjcHZdHQI6W9KyM710ys/kCTqbMfRQzOgTE2HcCIsyJfHJ/p5mi5j2oe8=
Received: from MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21)
 by MW4PR21MB1971.namprd21.prod.outlook.com (2603:10b6:303:7d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Tue, 3 Nov
 2020 02:04:35 +0000
Received: from MWHPR21MB1546.namprd21.prod.outlook.com
 ([fe80::a4a4:2fa7:b52a:7f1d]) by MWHPR21MB1546.namprd21.prod.outlook.com
 ([fe80::a4a4:2fa7:b52a:7f1d%8]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:04:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Thread-Topic: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Thread-Index: AQHWsX5b4+ft06KSG0GlKPe1Plvd8Km1p+ww
Date:   Tue, 3 Nov 2020 02:04:35 +0000
Message-ID: <MWHPR21MB1546A90F8F27C318D085462EBF110@MWHPR21MB1546.namprd21.prod.outlook.com>
References: <20201103011136.59108-1-decui@microsoft.com>
In-Reply-To: <20201103011136.59108-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=da49a550-959a-4649-b18a-41c897c5da44;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-03T02:03:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:881e:8402:7b3a:208e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db8fa206-1cb2-40a7-cac8-08d87f9cd011
x-ms-traffictypediagnostic: MW4PR21MB1971:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1971E1AFCCA978CBED9872D0BF110@MW4PR21MB1971.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmwIt3wg/CxkI0Xar7m68GRhUzSUD9do1th1WonZ6rFNN79HosNEGKy+m5Qm2gm1QWM1Vf7+klyuqqjpTDcrwZQ9D1QOLchdgMv6dyFmqzavq0pIMMcZejBT8rnQyAPKOjApDQShzAqI5H8xlKEzkJAtQovh0vtVTSWhDv+iWChulFCsce9rAoGJsZBlJSwHGmJ7TY1AMZ95jwygQFY/3yFCOlwODTgzWhbp6WhqMe9qCcJz6D4FCvVDpeNPRl3Vu4u2Ryfj6kwLxphMGSukgDT5caSfr6eo5xjnGmkmQZEi6a00Ur6zHpdNLgDflYKO+t+FVp9Uzki9VmRXxAUsxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1546.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(8676002)(8936002)(55016002)(82950400001)(2906002)(4326008)(52536014)(66476007)(7416002)(66556008)(64756008)(66446008)(66946007)(76116006)(33656002)(9686003)(82960400001)(86362001)(110136005)(10290500003)(5660300002)(316002)(54906003)(558084003)(478600001)(8990500004)(6506007)(186003)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WufHQNqx7LuVw1RXXp9+l5K6Uv8C+Zczoldhe0dnYOY/gqAe0R/CChKIkhO12+u7gTEDl1NkGBoWuz+vZCSf81AKms2YzEDG9C9UCbRilcwH0vIkGOjUin+xjydzbwovBF7ZGYIamyWRcC2eWtAPYVO18o9sEWb4M860YwYp00AJHwg32a+Oez+RxXg+lqdZMfWUkNzMUPbAg/UU3vkaGHEgUpNm+W8Q4cTjWnHfXV7xcCm9qMOu4Marffecxi+zltIndGOJbF9k9W4xfSNE511idt1bk8Iou8WFokhhzgO8kJa4fOHQecxab96F2pbdR8xRaY64sXGL9p7mVc9QaanqirLXg2jh0hm96E2Iy1SwrrKjSVdltEYogSCrfA+Uz+iigx6SW/5gD9uGpJ0HIhnheF3pvCbgYIKzo+JxufhX2F6oLON2riSzGjA1LcF811YLWMWopE7IUYiR+vR8hf/E0VSbv4L5oOVHWrptHVvohW1KXiJ6/Ntr5ZtvlKty++uIn0cl8ZLQogHyjQ3wrMuPMlNvXNaUorMMBqKE7XlumjJyU7nVKqaEyuPODUEvvIFzqwaYn14IluJyh5eip4PRn4BRf8/jMgomFCTA9r71QIDZrXUllZRTDm7GPxrel5cLyIINVNNTYawYYVb6irV+lUTuBMjTHysGhcb7jncq0bOovYMoNSFENXP7aac6Hty0f5mEFRwCMMEBlIKBwA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1546.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8fa206-1cb2-40a7-cac8-08d87f9cd011
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 02:04:35.3369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIfl/IPrcMO9/fjh2g/rtnE1lTFI2GfUUoGCHD+f/vRI5iID9RaLePfr3Z+wKiEPttZ01gkJPHHTf+vMhYVsbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1971
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, November 2, 2020 5:12 PM

Sorry I forgot to mention that this patch is based on tip.git's x86/apic br=
anch.

Thanks,
-- Dexuan
