Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6FEFD69C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2019 07:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfKOG5K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Nov 2019 01:57:10 -0500
Received: from mail-eopbgr1300097.outbound.protection.outlook.com ([40.107.130.97]:61360
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfKOG5K (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Nov 2019 01:57:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6j7rQTmER1QYU9d/lZUm2xdGNw9m2t3tLNzMxdeUaDcW0loauovxEoYtUZe8zEItYEuhQFBtSSQLaiLVy3N5HwU7GqBIgpWQfYrv+75pwl97WqByDBKBqQAJRBc4i9jTsEZZV05QeXO84WTA5Slbd3r+gajF7ka9yjOfjyudTRsa2XxYBrVbxIjOBb7Z5FA4Ya8IaSe3IjhXliQnGMhRFw4Gw4XDm4M6pUVyP+9eeDE/vUIcCDmjkPDu6Yp6jjhOZMQ4qMnfcOlkaRAcfNh2iwuE1q4Meu6O7Lv4Wdd26RqBb/wCt3Oixb7N1gzgYnL14UPSs3bHGDSL8cCyHZ4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI2CgJ/jP3QJ9tQhL7R8VOXNxxLqtJIwZlot25gZquA=;
 b=l9Vqfwt7wGM8IFUKYK/FA6bYxX+KMi+b1gI0bAsfoxiMcw67Sv7sGAvd2oa6sH8+fEZ3E2ZZn7jVM5JxEVlCIFI2efDskyprKvwWCrpFkoMkeBPYNownP48oGOLVXSXXB1cCCrTrV9WR8pz37wQzxt//RHD6leQeMqyseWJBqc1dMJwwFRPSXCPsecWnpYrVCCLYPGboF9LmOKKG3Q5eF6GZH/nQnOzZWe5fvHtPyr2OGAnyM4aynadfWKFTCNDaNdPzJ4GCRUffwdFgMgH9zI2fQfeHPJg8ZTkyniQtSIhJMNFsxkpC/Ija1ZwT5dltwFU9r0L+MrYPzw27ypDsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI2CgJ/jP3QJ9tQhL7R8VOXNxxLqtJIwZlot25gZquA=;
 b=VkFJTElgErosLD0H5L/E0Mi8ncwsof9WxB0COSb2+48gbrYKftkr9gNZyEXTiZNgKRpNvzCUH7waC3um3eefwVmcVXrDgecEobxR3qKhyw2cavKc/Prsmh9jzuwEJ7cene6XXJxPG9XtAhRhWQAZuQNvwkspryeDjhtA03601TY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Fri, 15 Nov 2019 06:56:21 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2474.010; Fri, 15 Nov 2019
 06:56:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of
 Hyper-V synic
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of
 Hyper-V synic
Thread-Index: AQHVmrU40YXv2apLdU6NdUllgrDfP6eLzYHA
Date:   Fri, 15 Nov 2019 06:56:21 +0000
Message-ID: <PU1P153MB016977F8FC0F30A464F51B16BF700@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-15T06:56:18.4017159Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8589eb1b-a331-4b4d-b4d8-b3fcec9a921d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:4883:732d:5e46:8ac9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c93558e6-0b17-4895-c12c-08d76998ec6b
x-ms-traffictypediagnostic: PU1P153MB0172:|PU1P153MB0172:|PU1P153MB0172:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0172DBF8CA6A011C2F3D7833BF700@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(102836004)(5660300002)(186003)(76116006)(7696005)(99286004)(8990500004)(10090500001)(6506007)(6246003)(6116002)(2906002)(10290500003)(11346002)(446003)(33656002)(476003)(52536014)(76176011)(486006)(25786009)(22452003)(316002)(1511001)(46003)(110136005)(478600001)(53546011)(14454004)(66946007)(66446008)(64756008)(66556008)(66476007)(8936002)(9686003)(8676002)(81166006)(81156014)(256004)(14444005)(7736002)(74316002)(6436002)(86362001)(2201001)(55016002)(305945005)(2501003)(229853002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wib0KGNJuyXHLgfoJZ7OsDo+rXFbn5jUj0rNQuFbULh4SbEmDjq9ZmYJQT5RuqsMgfb4YDH9ff7Lrxfh1AtLJmkAQ1ivGq4PExgyTh/ppBQsBgz9RZI+9VbcLXaknawQIhstetSP/LJI7ctPmhbOC6nWDOXEKCqrEz2pFJWFVaWC07s2pr5LTH3lHQWT2/f3M8UN4EyVz6btjswYL9xwye57iRyhycp9id+MGt6obD4kbf233QspGwn0i+lha+EuXUPmqC2h1Dh9WXda/WLeNVoKuoQ9w7vh4uhj/97LYCzZYJsFioDL2wxhl77NDmiFm/Rs5ZOMm7gwa4rcrzSrg8okO8kOs75heq3v9yx0llHrGtUuWQGUsrOZANE6SPyc2oFZb5m7/Y/6vr2+6Ir/9CiMi/l39pijzPnkSpy4cFUlr4no7zKEALL5oLiJvD3E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93558e6-0b17-4895-c12c-08d76998ec6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 06:56:21.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRdthVDo0Ji2Q7jaN3QzYnOgRJ5Tjmu23n4zzImMssen5tW67YzGQ7My1Ti9zPgdYndkv3dIhZUWIEABqwuQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, November 13, 2019 10:32 PM
> To: linux-kernel@vger.kernel.org; vkuznets <vkuznets@redhat.com>; KY
> Srinivasan <kys@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; sashal@kernel.org; Dexuan Cui
> <decui@microsoft.com>; linux-hyperv@vger.kernel.org
> Cc: Michael Kelley <mikelley@microsoft.com>
> Subject: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of Hyper=
-V
> synic
>=20
> The crash handler calls hv_synic_cleanup() to shutdown the
> Hyper-V synthetic interrupt controller.  But if the CPU
> that calls hv_synic_cleanup() has a VMbus channel interrupt
> assigned to it (which is likely the case in smaller VM sizes),
> hv_synic_cleanup() returns an error and the synthetic
> interrupt controller isn't shutdown.  While the lack of
> being shutdown hasn't caused a known problem, it still
> should be fixed for highest reliability.
>=20
> So directly call hv_synic_disable_regs() instead of
> hv_synic_cleanup(), which ensures that the synic is always
> shutdown.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 664a415..665920d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2305,7 +2305,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	vmbus_connection.conn_state =3D DISCONNECTED;
>  	cpu =3D smp_processor_id();
>  	hv_stimer_cleanup(cpu);
> -	hv_synic_cleanup(cpu);
> +	hv_synic_disable_regs(cpu);
>  	hyperv_cleanup();
>  };
>=20
> --

Reviewed-by: Dexuan Cui <decui@microsoft.com>
