Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77EF1498D8
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 06:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgAZFFf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 00:05:35 -0500
Received: from mail-eopbgr1320124.outbound.protection.outlook.com ([40.107.132.124]:15712
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgAZFFe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 00:05:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbH0Aj3ESvVnCWMDdklT2aZd3gfcckrzT8Kdkz2VUoHvCxCaa56J2FgjUSsSUvf36OShdxZH435OHrXWa/47Hvj3ovfnQB72qQ6xMiO8BxtBMpSuWDWQNnCD6s9A0kECqmmd4W695dwSSVsgjWdgZglGT7DjI65Eah7Gac2Urdsu20fcq7wfkBQek9gnnWosnQDeRhcKXeCC9ZJpwqqNo4PUVW5HK6iY05Io5uvgujS3kb0Q88/kggicgQ5AUE0jMoYbx+aQeZhSOEk8QE6SR0XMcEcJD777yEUS0MVsmP+B5tP1QJnOOfM/5op3kW9PB8ltXtWkgbjbMCVEY5o2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVgG22YDSu6eFa6ojgjjD23yFDHa2hZXpjV+txwXCUI=;
 b=VYkcOXlmzKZBB3J3gQuVBJhq2N2AYRFDdkh6AxnTGOwaCgnPXPBg4Ve6qotC4l/Yl1AA+hdR6/IGbmh82ItTmfTLynfUb1k3fRhewGP2jzKATC8TaZJRyKDzZwLUFMqhznAVnasfS9Pf0efB2LT9obbmf1CePl9j4YIXwnn/5LE93dIqV83Jt9wKc3plNQAOuyTQ9IMe2C6c2svNVIjEGE9btO/5/vajFLv6e/i53fRnErpihDd8JF9N1Z4KjrYCnXjGwx+BqZbsCDbuYyJe3cT8aX+ZYUI0MmxdWXjbNDr8VN+KJUtYqEMYgTb6R+BLo23VVktpRc3Oyif9u6VaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVgG22YDSu6eFa6ojgjjD23yFDHa2hZXpjV+txwXCUI=;
 b=jzTZ9akcBSgflKJLZhxCm6PrbgLIjVhOpRecwqB9Z3vusodKYCArcod7jT1ItUFbE7rOVIrJkJBO2tSitcr1Z8eBtxhMYSl0jyAcLD035EkBoAdvwn6JxUs0WOFs1pNCoonVunQEsmpyikstiXvqSljn/hZnVLMHBSkgtIqGUi4=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.0; Sun, 26 Jan 2020 05:05:26 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2707.003; Sun, 26 Jan 2020
 05:05:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v3 2/4] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH v3 2/4] hv_utils: Support host-initiated restart request
Thread-Index: AQHV07lWZvLQXaSX3027E1rxrSU606f8YKbggAAD5cA=
Date:   Sun, 26 Jan 2020 05:05:26 +0000
Message-ID: <HK0P153MB01485A90EA8D0D7A8CF5F97EBF080@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
 <1579982036-121722-3-git-send-email-decui@microsoft.com>
 <MW2PR2101MB10527D5A3D4F7E52568D119DD7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10527D5A3D4F7E52568D119DD7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T04:56:57.5354335Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bd2cd39-837a-4776-b220-3ec15095a9d8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:67:1cd4:d237:9171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 772b5122-b867-4991-7603-08d7a21d5b3c
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0259B9C8BF037994DCA94534BF080@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(8676002)(8990500004)(66556008)(81166006)(55016002)(4744005)(5660300002)(110136005)(66946007)(76116006)(9686003)(478600001)(8936002)(64756008)(66476007)(186003)(316002)(66446008)(10290500003)(86362001)(7696005)(71200400001)(6506007)(33656002)(81156014)(2906002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkX9zpNuL+TL6juu0ZVganajGCyXzxWcqxa8+D3RDkPz4EHu9oPbSoL6hO3X3g+0/b+D2zCTr6MAPn84uk5vwwSTcpbM8tUgHzHdw/osp5nftw2rH9RaTItfiKFCEK37CEwhp/hsehe9WRDXJqVjPhGPHI8mCzwP57Fn3MpQTRCu5zA79Yy43tQXyWmEiK9ip3E7E5dxM0xMZNnRO/La5k71J2Sv4G6WoBPVMXkO7a490PGA1NrnlObU5LMpz+qOA02ZjHR7sPcfIzURwXfyZAj4wb//JqcRjgJ5Sw1WRChUdFVweWdftibpZHFmwYbtxON1nLfalKCFaiigfNVo2uUf4UTN8RniptA9VAbDcATsYwX+mPXvbzFWVdt2MWs1b+akYfhKIYr+Ss8mPKL1OjGxOF2P+kEXI4ZPcgPLxxfsjyqLk0gqYjBqeNvBoNmA
x-ms-exchange-antispam-messagedata: PECizr0kj5GRdJtCslFbAg+Ikil9JrST5dCkZ9lHj3/XXU3WAHnmFC1g0C6aMKgODnCSdW09UCwjKL9sk+CnzTztMVFhCXf0fE2wSRCcuUCrhc+bAwOpbzKgXaIQQlZZlhVj5DctivqWQxE4fl/blc/oNa3fZWhoxHhQORnVSoD/tr99LMzHHV8+XBEDWnTUFwZHnn2wswQJrKfdTaXPwA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b5122-b867-4991-7603-08d7a21d5b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 05:05:26.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7Lm2beWtcHyeeLg6XMRavq6iRQSli/nkWKbiYI5SEu+ja5G5MI3pCU55ShI+IN3vEhNBJ+UBGfGTwk+ME+2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Saturday, January 25, 2020 8:57 PM
> > @@ -186,6 +214,8 @@ static void shutdown_onchannelcallback(void
> *context)
> >
> >  	if (execute_shutdown =3D=3D true)
> >  		schedule_work(&shutdown_work);
> > +	if (execute_reboot =3D=3D true)
> > +		schedule_work(&restart_work);
>=20
> This works, and responds to my comment.  But FWIW, a more compact
> approach would be to drop the boolean execute_shutdown, execute_restart,
> etc. local variables and have just this local variable:
>=20
> 	struct work_struct *work_to_do =3D NULL;
>=20
> In the "case" branches do:
>=20
> 	work_to_do =3D &shutdown_work;
>=20
> or
> 	work_to_do =3D &restart_work;
>=20
> Then at the bottom of the function, just do:
>=20
> 	if (work_to_do)
> 		schedule_work(work_to_do);
>=20
> Patch 3 of this series would then be a little simpler as well.

Good idea! I'll do this in v4.

Thanks,
-- Dexuan
