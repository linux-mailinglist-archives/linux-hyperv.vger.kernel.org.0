Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA072B39CC
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 23:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgKOWLk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 17:11:40 -0500
Received: from mail-dm6nam10on2115.outbound.protection.outlook.com ([40.107.93.115]:21534
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727656AbgKOWLk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 17:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+0+RgKcE86to0n1jk6uC8L1bRVUYtNCbSovjhG6OAFDJd7OdS6ZEtcwVogF+brW7GIww1anD6pP5XyVOJcfK60VlfNTOvCv/wxEjnJNdJWX5r2vF2QKZd1U4lhIZxPqNxuGRAloIHtcVPXPmGxVHXXsPRj/LEbWxzzjuS3LmNKzI2Cnpa1GQRxxAjr28GrMp1WJywobLElJEQJ+vOeQfGNj+A5yK7pAuKjSbgurIthWYeDpmMTJpHIyTwKvXVCoxs9zJGwSEmDfNQ/frQ9OGswCY8q0lP1T9D2P6xeZqB1awvHXSVu2/Yfr/iorNrNpWyifBwFbqbzGldV39acIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OBNQZCTpGlTESwmTMKu5+WI+K743l/tp5JhqQav9Tg=;
 b=OrIKT0DE4albVPk+eyDOYGe9lKTC3i0W73hcWm43BYkLr/wBKg04SIUQHXl4pqd106QwKmCXcpd0LUAbc7xPPdg9Dl5hmvFvgF9y4R6ERyYN+a36E83zwDe9oQ44r31uLxkC2KQ3ekXbiRxYmdWSkQulHhqdliKpu+SU9e51fc1V6g+tYOHjBRvRtW+t9RpyOCkN+mMPMW3j2IJ+rlmsT4UVQ3bYRCj1MbMws0abQTHAiGl6kqwcKPrM5w0sqt1CqxTM+Hew1/V+Sj+q5xjz17aY+qjo8QiA9kiuTIlxetb3CDi537/N77uQSUKEzH21MjVPSrxxnWaBHsqJi6e6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OBNQZCTpGlTESwmTMKu5+WI+K743l/tp5JhqQav9Tg=;
 b=EUwJ4z7ByrJ5aBsMM+jFPR2ciiDnLFHFIbBlpL4XfMyzjLX+kI39mKWvLfIfSk0KAJuTNAQiW1JWX+6+Sy2W501yleb6M9jDJK8c7OgUmofd86ban9smFJjCAlA/5IcPAPEpwFPmdRZDRwLooWgbJ12PruEp+B/LFa4jmS8VKEU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0890.namprd21.prod.outlook.com (2603:10b6:302:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Sun, 15 Nov
 2020 22:11:33 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3564.021; Sun, 15 Nov 2020
 22:11:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] drivers: hv: Fix hyperv_record_panic_msg path on
 comment
Thread-Topic: [PATCH 1/6] drivers: hv: Fix hyperv_record_panic_msg path on
 comment
Thread-Index: AQHWu4mj4353Jy5R+Ey/So4Y7vDOI6nJwTIg
Date:   Sun, 15 Nov 2020 22:11:33 +0000
Message-ID: <MW2PR2101MB1052D49DFD8B107E82819D23D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-2-matheus@castello.eng.br>
In-Reply-To: <20201115195734.8338-2-matheus@castello.eng.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-15T22:11:31Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50e27f4a-5b56-49f3-9e4e-e5282f680b51;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a56a6e41-8bdc-4cba-eac2-08d889b36973
x-ms-traffictypediagnostic: MW2PR2101MB0890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB08903ADD386589018AE6E788D7E40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NO9vra0SBM9f3nOnisPaXX0o9U2GJZAgDpnMpFtYE3EwBOCgRDDRvRPJXL4L/yR+HlzbIHAmggXtmlGnuT6SyZnlhKqJEaHrxK4QC7tNHfMRK+K9qtTbL1LQqSw0rBQUv0fv6fxQaiYyPGCJA7cMi/1DDbLnVxrRxIBuPQ5sHvwPsvO4AKJNa9yjZI9kqJgSdk4djOhrqUXjR7+RRvqGic91Ns1+mdIsO1FtcYvKTkQO+db0XSa69NRsWd2S3BVCc7kRQ6T2jy6d7x0SeJ1TZc1CvGTBB7nl3UUi6CM6g20bo+R5eCiUp5Xc5s8Ayb9ssZ+lBLxzO98MpMluRSFPlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(64756008)(82950400001)(7696005)(4326008)(316002)(66476007)(82960400001)(66556008)(8990500004)(5660300002)(76116006)(9686003)(83380400001)(66446008)(186003)(478600001)(2906002)(110136005)(71200400001)(55016002)(4744005)(33656002)(54906003)(6506007)(26005)(10290500003)(8676002)(86362001)(8936002)(52536014)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: r4hAVLMkXOXqhCpTdqAGgGOxO8c0zlqJCIyFICQg9Psz+N41rQt0NaSrSb2MVUWCvd4ycj7iJFK/JE8k1WXX7Tt8ZuVLTi/OpIOSDOAaBrjgMrETAhQI/JnKhwdo9AYv8EFbDRUGtTob/bqF/F0y8EV0Z9z3fCwmxwBY7MdtX3yFB4R/49aERHQ3i9Ian+A88EU/L78OC5doOkztAsBbP0GQW2TkEQH0lN3RHayRItTRK1gHev3ysDtuCA6qGxBcekFUyWRRIlW9wvd1wY2eJGmidX0AGBZwBQLnT3/Nnt029QxWG3eaJKjFDhZl9594MDKu5MPw8Qtc6B7V+56LWeMR6GCdMW043ktPNNXNNtRQgJE5UcZ2T+hJO1CwTUzajOqMJSFgxHTZl4J0HUaLCCTk6jT93Vv7Vm5RIvfWhSN7IG1H7Bo/zq9eOzaIhCLh8EsMlJ50lEWWhoxnyJsyzSu0d7VLHNMT4LG5lZki/MtV5jODzxqyd+8KXm4PhEO56Fm/9Uu9VVd3sAnbUe7098u7V2jA1wbFOAzf5KXwZsN3XTcqPSQytACpgVgIdNFOQU530ontUNvqaHZGqQSnkIvmwE79OuJaggLVmKmrji35ER9HeX5MA8Q2Y7NBTKrxrLzUe3Bg3nRf+a01VdR2vKkx130t0T3NmNlR6vUxVnJ+9Miy7wGCFZvHgYvQLbDgLC91atcGbdaTNGs11okx7mpWs2On3QbK09NKIQyxaGxnYwuxMXJjsaNV22so9tb7cFtBgXyDbWxRAaLoEUEEMoy5A2ZPZ8rpRcu9jTEKa7738UuxarJuZPctU4qmLPJxXs3I23RrBR6It6hcKqpTqpqdugoPDN6bsfS0oLKNKVw3IL1c5QzWOrzDwHShG1e/QJWfH3aKdcqoVT6awbeU/g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56a6e41-8bdc-4cba-eac2-08d889b36973
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2020 22:11:33.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba2YVG9OEXxreg5vmKZjuHvlA5bXQdpyn0ZPociw8ffKswgO6NfOIEaG3B0XNyGzXLefAC8SafBBGkjh5LB8BJB9Ugk1Se2B5+fipir/WW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br>  Sent: Sunday, November 15=
, 2020 11:57 AM
>=20
> Fix the kernel parameter path in the comment, in the documentation the
> parameter is correct but if someone who is studying the code and see
> this first can get confused and try to access the wrong path/parameter
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4fad3e6745e5..9ed7e3b1d654 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -55,7 +55,7 @@ int vmbus_interrupt;
>  /*
>   * Boolean to control whether to report panic messages over Hyper-V.
>   *
> - * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
> + * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
>   */
>  static int sysctl_record_panic_msg =3D 1;
>=20
> --
> 2.28.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

