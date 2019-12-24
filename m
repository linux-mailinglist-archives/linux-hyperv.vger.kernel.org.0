Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726D212A32B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Dec 2019 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLXQ2r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Dec 2019 11:28:47 -0500
Received: from mail-bgr052101133019.outbound.protection.outlook.com ([52.101.133.19]:1778
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfLXQ2r (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Dec 2019 11:28:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRTBOXMcFxx53ShFQveuAOzEKV8/yX1sTuFrPZMTlkp1dVa/FcmCA8hvyNcGaNy1gwPKXWBx5KQnIAng6qf/9zmLJDrw4aLuDSjgDYryc6dUptKaM7W362JfrB0dggUw+mHBjQr3HU8HUiaJfCJv0fOpB1Eper4eL5ORIK6fzW6m93PrHD8p/VnOeQMcQNVX7i9dZN4xeBpQCfMZ+gVP27xhZWLY8BCDJjMgWgzD2x8N9N2hJrsCpSJgajgOPRcXq/P7GcTBYa+4OV+3ryVAZv21k5e4PchLFWJj/pVIFDlk2tOe88+dCbHRbVrn8Cnh3SuSj/uS9y7BYOlJWQEpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh2X4hIvQChZMgTgNDyVZw91cVKQp4qadmXRJ71qBFM=;
 b=N8GgYAPXg63fupEmy15O+0OmOCqHmADONDWbaDjU2sx5fCjdBinXE6fiwt/9gT0IlnlHRuDX+xfMSbnpL7YYMXb/xm6JKw4t4xbrNxiqXhUAL1uMtrqa6SDacCmU7B9Hw+EN/L2cxwU54V7G1oyOktFBH78GxZr92aABcEwxMJfa7TfA5/A7a1K6Wz9UKTF8rQYpvVpH0VWxOmHpwA5mi+oVXXw0WF3JEqrGnTHZMlJupbJXXhqqSSTebcINU9QhnRPVuX+EaSKuWLGqP5XNui43uViZFKFgV3J1HBhyMDu6u5bzUMnMU7s6/p/Scw3MvVfhe/tzql7K2XbXFYfnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh2X4hIvQChZMgTgNDyVZw91cVKQp4qadmXRJ71qBFM=;
 b=U7OjETD8h9MFHIYFL9u1gl/2OLWaXCrEWDeoje20iuEcZfhKBw+6R+XLNTZkwDq2x67c40YYRrXHc6mlL3SFuhTw0zVDhu2BWbyrU2UdeGC7LQm6gbnEtsy5jCMto3gyfvqJ+wpnH2jAToqfWWYmTL1O8ryfOoyoj6hfDZaAgpM=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB4254.eurprd08.prod.outlook.com (20.179.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 16:28:36 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 16:28:36 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: flow control in vmbus ring buffers
Thread-Topic: flow control in vmbus ring buffers
Thread-Index: AQHVuki/5e8dawcR8kGygRTboGxxoqfJecsA
Date:   Tue, 24 Dec 2019 16:28:36 +0000
Message-ID: <20191224162832.GA168681@rkaganb.sw.ru>
References: <20191224105605.GA164618@rkaganb.sw.ru>
In-Reply-To: <20191224105605.GA164618@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0501CA0025.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::35) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba738b7-bcce-49db-1710-08d7888e534e
x-ms-traffictypediagnostic: VI1PR08MB4254:|VI1PR08MB4254:|VI1PR08MB4254:
x-microsoft-antispam-prvs: <VI1PR08MB42542A9D05AF0BB7089D07AEC9290@VI1PR08MB4254.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(366004)(136003)(39840400004)(346002)(376002)(396003)(189003)(199004)(36756003)(8676002)(52116002)(316002)(6916009)(186003)(478600001)(81166006)(81156014)(8936002)(6506007)(33656002)(26005)(6486002)(4744005)(71200400001)(1076003)(2906002)(66556008)(66476007)(5660300002)(9686003)(66946007)(86362001)(66446008)(64756008)(6512007)(30126003);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB4254;H:VI1PR08MB4608.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;CAT:OSPM;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORSznaXpo51bUv0xwAg4x0rphZiEhRzRUAp4Zy9QM0Hv2uc6J86DbLEzJgkImt8n4iwTqj64pv9To75ePCqGkVYLOmn7Z5C+dCWjJoW/6dQ0+kITRAyJzkYFeInd7uLq5ne1XFTMfra07RJf10nHkktbE+QPk2rmhDbuMBAPT6V98aJXK5QGFFdW1IDnNHMA9gM1Bbdu7C60OMHafztP4WczwO4a6mo7Fh8CcXdBaJ1y7WHeh0mwa5fpch0XmCdH2artcexKE0u7adB1Ti7Ex0Gi4zE4ykWrOcSMWKZoKei8GEEgY4SqiyZhjV/KpTMkw6iq8Cql35FK6n3xk01EH/7YvmhtjwgTRMMuxxmGj/bDreY6lc9zfXCuYU2TNXuap3LTzgsB6P080CLTol2XpEnAagUFFVORPRYKM0nujVyzTEEXRyMVXHcnEolT8OwXRlIYITZst4We9oX+CJWVQMzItvji7+j02pM8ayymegHNy6lvv5/cbRV2vf1EMvw8FRk4kF/si6gHquIVShLqzXZfYUNjJmTPagBWDJLo9mKZkgZmMuI7fnbaAlZplaB2VpNGPQzJetewWx0f/A3evwFQ4uCmQXsXkqSFdxNtYNKhxfmclvCst7615QTrhllcCbSoqy7IU1xlzJ5Zr2IoHuQ1NanlNC9zo112CXY0GlSPtINgvFx+XCalHTPLyEzo68ZPcS0xSrxMf64Ejn/pjzTsEobXg9bgb6mqi642atTEqmbAr3IJ8cmWLFdVOBg2/noCZLC43xeVDVCXwe6H7Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FC2DE178E5D8F4DA1C556E01F8A6778@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba738b7-bcce-49db-1710-08d7888e534e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 16:28:36.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uadQj4o5XqxhbZOwehAdiAsbOtq06aSBleRenk3L+LbJIpzHlIupMcWe/23zH1HxVD+skiNQ2/F5T6r8prAfVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4254
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 24, 2019 at 10:56:08AM +0000, Roman Kagan wrote:
> I'm trying to get my head around how the flow control in vmbus ring
> buffers works.
> 
> In particular, I'm failing to see how the following can be prevented:
> 
> 
>      producer                     |       consumer
> ==================================================================
> read read_index                   |
> (enough room for packet)          |
> write pending_send_sz = 0         |
> write packet                      |
> update write_index                |
>                                   | read write_index
> read read_index                   | read packet
> (not enough room for packet)      | update read_index (= write_index)
>                                   | read pending_send_sz = 0
> write pending_send_sz = X         | skip notification
> go to sleep                       | go to sleep
>                                 stall
> 
> Could anybody please shed some light on how it's supposed to work?

Sorry to reply to myself, but looks like the answer is to re-read
read_index on the producer side after setting pending_send_sz.

Thanks and sorry for the noise,
Roman.
