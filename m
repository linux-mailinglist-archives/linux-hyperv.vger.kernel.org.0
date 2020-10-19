Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F90292153
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Oct 2020 05:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgJSDC0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Oct 2020 23:02:26 -0400
Received: from mail-dm6nam08on2090.outbound.protection.outlook.com ([40.107.102.90]:55393
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728538AbgJSDC0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Oct 2020 23:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMG9DMtht5yitE8ukgbgGopjaTSBKgKfV3lmJfXBjRZh/hr+wl5SpuRL/vv4q4BsaAp7sQaPRdnHP79oMGCWK1WPVh59dLuZdoJGvMCq+jP/hbtb3Y4+LL0a0Wg80r84DpYqEEPHWSekDhgIzE3TZqlYr2Ldxcr38HfHHzEOky61UudgwuspVT30otKUVXSXYs1+nAIkH1PeTBA+wwmxfeQWSNngIiY4xGIHYlSx9GPJERIoZzXA0/ZbQJ48rU3jHXGT3RNhJwnUmzmLkfl/E+iyUkGsFqpX5ae0uhQyXtoTSZkdKDPPEi+vNYDwIOnbFsTyfqSRIAsTkl+qI1fSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jshx7hZg672o4jcGLVW2lraVOJeUriGmJQ7x03HfBWk=;
 b=mAOEal2MK76K46RaOsqumE5qleLPCvxfYmCT6UtEEQ6a3FtADbh7UiVt4E24ARLGNNeYcKXEOB1I6BCDj6RcGB7/fbOYvT6Wa7FTeMnC/doLDlvsFkRB4gMr4CJ3eOL4Dr9W2G9gPg3iUmnB52NZctCPV7O7Rf70NtuAAGQLCKPssvedPysFK+75yfSCmf9OlXUFB7AjkVbf58IPncx5UwhJb8cQ0IcL39QtfHdPK9dX25IdyrXGsKTFPNqNgsST2bWPfTPnSXymvW26GIraGNg9Kk3W4pR+/2xHwuXpu3jVLvurhu70bs4nEtjdS9RZ6J816ncUzTgxlYN5OM+rmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jshx7hZg672o4jcGLVW2lraVOJeUriGmJQ7x03HfBWk=;
 b=LWXvnBnBi25cT1Mz0BvSVdc1DT93EAnQXN34QQKNNAT/vMHazMO4vyuaHDCg3dVkH9lOTAqFDQv4CSkAhy91j5XaQN+GiEW2M8YqVPb6FZMYQ/cuoCNEPrLUqy6SF78GlvQk0aYWL5kXIt7hBMwEvM9bZdqoBFpRBXbZEaevqro=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0924.namprd21.prod.outlook.com (52.132.152.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9; Mon, 19 Oct 2020 03:02:23 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::101a:aefa:25a3:709c]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::101a:aefa:25a3:709c%9]) with mapi id 15.20.3499.015; Mon, 19 Oct 2020
 03:02:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v1] hv_balloon: disable warning when floor reached
Thread-Topic: [PATCH v1] hv_balloon: disable warning when floor reached
Thread-Index: AQHWnUJmr5zYZi33iE6Qbgpur5d1vameTNTA
Date:   Mon, 19 Oct 2020 03:02:22 +0000
Message-ID: <MW2PR2101MB1052BA9AB5DB8C11D7F9CE33D71E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201008071216.16554-1-olaf@aepfle.de>
In-Reply-To: <20201008071216.16554-1-olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-19T03:02:20Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e26b96c9-bd5d-4999-88d7-baf04ccac9bc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: aepfle.de; dkim=none (message not signed)
 header.d=none;aepfle.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8085a5f3-cb4e-4bb8-85e7-08d873db66d8
x-ms-traffictypediagnostic: MW2PR2101MB0924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0924610ED720777AEEF824ECD71E0@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JbGieQvvXHMhnxudqcX3NQUwqYdsuXRQ7hTab3H2PBx0THLDZhBvQGk0QsOoEcAxnhD62IbCcA8PRyh5H/78OSHCq64WSPb5O1kZc7zPWcN7AlV1/e+Sk3/zcQ+I3h/l4TIvgUcvCuKheKUAVhLCiWGRBhOxYIoPJ9qx8QwNxdwyljP0z5vQh3hjmVN/aFdCV2SXwMKtH2PT5EUdhlNzUS++V6GzaEM4kWUvQ0VoBTD3QOXGr1ogAQ7EiIAyy1VzI83c72NRPU/jHTF5gSbLimtHoPCijYJCbr3e8kCQ3W81S2nx8Ce9ge/F1a/3bNuPGgKtNswLt2rOh8ARxTgS7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(110136005)(55016002)(66946007)(54906003)(76116006)(316002)(86362001)(5660300002)(66446008)(2906002)(66556008)(64756008)(66476007)(10290500003)(83380400001)(71200400001)(52536014)(8676002)(4326008)(478600001)(186003)(9686003)(7696005)(8990500004)(6506007)(33656002)(8936002)(82950400001)(82960400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: injPb59TpgrF2teIsYA6EVsAUGO0QYlDLfcxgIyPK81bR9RtSY78HLzV5HCXMVzQvfSiUBn/5fnCgCMtlRnTLen2QNe6AqdK5C9OWF8NUb9zkM+H1ForPz+mwnZu0y1Lpmj4nINqiEXajUn5jybJ7PIVJ/pzKwvwce+WSQjD2z4nlmduOi8vNIBmekdQlTHScbfO2XVPTlm5SA4GZZGHNmnn0gnGelJXaqqXFL1ar19PcM7+3fFRPkY44Ljsd1hw6q8f/c2zL2MUcsMnjwMZgSAQisxGQUJri3L/V8p2iqAEVoTDRKp2HHacvNWMXOxOcg+bXQYtQKlwy3hY3ECtjMV56Gc/owE7DC7vJYv7gDh0qENEJK5mPOnLtudqYElWttizu6I/sA5d+rLATZ2kZFlgrJCiXKozDR3gUdPhnBYlomM6W6URn5jLqTyUDRHLc6J62VAcTWqC4rQkWq4zOhcLmd2Ut0inUDUQ9gqTO0XSXCVK114XmPmPrywaw1R/40Jxy9GBxAuitUicRYxAbs8sIgE2Ck8H4HoxsvxIDNhznI6NG2j5VisskYKXhqNSUA1wSQINhkyVtWlC92cp/hJ+5gcnsPp+t430R9TKlGjCcgWKw44yiLnv6TjpLCZTZC6gYHKI4Yl8Hl2gpGyH1Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8085a5f3-cb4e-4bb8-85e7-08d873db66d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 03:02:23.2044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2O13PYLCNbMBFFkHVU+T/t+f3PGMxrq5Qt9/FQ8oHJdbZSCMzSJX6Ky1i6eqSCk642SUn669dVR8MhjcRMfd0rZ6AWPnhtcKosPbnXUZwKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de> Sent: Thursday, October 8, 2020 12:12 AM
>=20
> It is not an error if a the host requests to balloon down, but the VM

Spurious word "a"

> refuses to do so. Without this change a warning is logged in dmesg
> every five minutes.
>=20
> Fixes commit b3bb97b8a49f3

This "Fixes" line isn't formatted correctly.  Should be:

Fixes:  b3bb97b8a49f3 ("Drivers: hv: balloon: Add logging for dynamic memor=
y operations")

>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..0f50295d0214 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1275,7 +1275,7 @@ static void balloon_up(struct work_struct *dummy)
>=20
>  	/* Refuse to balloon below the floor. */
>  	if (avail_pages < num_pages || avail_pages - num_pages < floor) {
> -		pr_warn("Balloon request will be partially fulfilled. %s\n",
> +		pr_info("Balloon request will be partially fulfilled. %s\n",
>  			avail_pages < num_pages ? "Not enough memory." :
>  			"Balloon floor reached.");
>=20

Above nits notwithstanding,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
