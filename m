Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9F5391CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 May 2022 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbiEaNZm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 May 2022 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiEaNZm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 May 2022 09:25:42 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91C62A2F;
        Tue, 31 May 2022 06:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIWNphwQ3ZglPdXdrXuAKvAzDSAsnqt9dr5AzwHaClekCjawGZu/Z5fqy8/8iVdeE7XkHmPS69L/p9kAFUopqBS24TIU6Fp/Neb+/lfhCwUAntEXChvSxvPv933hboejtzE+nkNMuFoTpc0YM0QElB4W1LtLiypebgsYvYZooJDII+Jb61Us3tCBCLN+dDBhfiWom1qFGl/gt9FAdT1S6DXo0Gelt3bMJHeEAPnIHpXUblzGZMItR54eZR7raKWZfUPAhqGHk6GZ7f7SRyU+0cvfTiaUjsadyEkTcLvT/mQRm2YVCoW4clrZXYtJh6K6BpOV3GofgFKx6PUCaHyWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPNoozL+JmKsOTlwFirh7mmjVy6Tb4a+sfC3MudL7yw=;
 b=Ob1xGa3u5OZ70K2jd2Hsvp0I6fqgGDJ5QzV7plQIKu0Cf/eutpzBXwu3sc7A2Oo+PQQ4bfUjVbv1aPQ2zAH+hAKXhS4rvTncxLcNhbTRPxMwHSCERMvgZthQJGOiw6U03DDC+J1VH4Glaiv5CJ0YS76GK5jv50N6ar1SG+SO5t0WLpNL9yUOSuhHcetO1rbqxjeYUlR7xdkYg56rh57NRibroskUFk2oU6DJmV6lcqN7ueezF390fW2V8yTu1EeYvgiQNpQ+UJQjcBfKm5b4nLE5RRLl/vgVDyAGCmI/QumZftEAEMY9E8vqMvCVX9EFGdZOfhqG/BlS99x6JD1uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPNoozL+JmKsOTlwFirh7mmjVy6Tb4a+sfC3MudL7yw=;
 b=bk88YXyjC++bLmywsbqxCJCNHlUEPOxwr+FJbt3yWytQ2PyyCEmm41vGqA7Xxj/AXQjb9yyNNAJXE+b2z6PMDel3xVwUmBA3e0Nv7TMGHaEGchxe5Bzt8/1wjC/G8wdnMkYfj+urV0jQc1MQseEwNAve2guafBHmWfz+BHPWaD8=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SA1PR21MB1287.namprd21.prod.outlook.com (2603:10b6:806:1e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.3; Tue, 31 May
 2022 13:18:50 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.003; Tue, 31 May 2022
 13:18:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Enabling WRITE_SAME
Thread-Topic: [PATCH] scsi: storvsc: Enabling WRITE_SAME
Thread-Index: AQHYdADOB8LAKpigiEW+vIrVrker9604+MyA
Date:   Tue, 31 May 2022 13:18:50 +0000
Message-ID: <PH0PR21MB302519EF7A7BDDBB92552BF1D7DC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1653899973-21039-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653899973-21039-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d18a6c4-360e-4eb8-bb8e-3a30d09e3190;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-31T13:14:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 200510fc-8b58-4628-0a63-08da430819f3
x-ms-traffictypediagnostic: SA1PR21MB1287:EE_
x-microsoft-antispam-prvs: <SA1PR21MB1287BC18FA1D81A6596F0CEED7DC9@SA1PR21MB1287.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2G29UMgdiiA/9vFA1RsjDXSQWtEjpvFL6Mq3qqlT+u/nac5G7SOcjT0snFlrpekyMlGYasQhT39w4iuDKkwIa+/JkreHQ6J/H92a29qgrXarCKTzhruPkOSU3DO113g9SS4mc6/7aRlOTehOrfxye2DdYlI25qX+vBmYxUhS/joyTIB+oa/1hYnfTnvZiHTTfC/ODOH0w6coH2p9A5W41TCB413oCi+Gt+5JAhPUf4E+OpdN64I8a3zg7U+LFBZqsziKEC5O3yz+FWaJ+VQlcJTPrQ8z7S77i/8a/BxVkcAgQp1queDtO+j1NN/H3p1OkdJXeErh4WtCwTEW/Ea+AzQomZziPTmd8GvBofbrBJeI4ExgN6ghnTo23j6snG1Jc1SAPEjAYY5T3sff0sWLkMfC2GffwjlC8HYiAie3Sm48NiDWaTtJtK+l4C9Mz7qUSF9mKaLme08WkXnIhnO/wtI4MwfTmZzD4pgutcurQ4dcZxT9RItS1NbxC5BTMuFYxnnZbWq8beIHD2iLtMUABseVVRqsNyZTjF5YIf0vAgv7H/34MrUpf9nZ5mG3Ph900m6SLOhX7+zhixKL+HaeH1gRZMO6XipzjA70jnuAUpgpCcp4svIVl7ZUqwyi3attjZOef8skyY6ZbSX2rqmjkLNTWsA/Eszh/GJY6yyznXlZUyN1lQ5i7HvD4n4/u0LpLOgPxfWfkCO/sWT60syI2cwZ2xw8SVzyVtRudZSiNQtB0Ql+Hu8BGmgHy+dt2C+Nw/fJjAFnS97wkdjfV6L+TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(26005)(9686003)(7696005)(6506007)(110136005)(508600001)(316002)(6636002)(10290500003)(71200400001)(8990500004)(86362001)(83380400001)(8936002)(186003)(5660300002)(66556008)(921005)(38100700002)(52536014)(8676002)(122000001)(38070700005)(2906002)(82960400001)(33656002)(64756008)(82950400001)(55016003)(66446008)(76116006)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYXhSUZCEm0gxcnPw5Nx9sQwduloOCt3BCU8Vd4yEgKKdMB/9F+uExBmjnRL?=
 =?us-ascii?Q?pYacvk8dyjHubRSI6mKFL3e2uM+Z3xr46Zo9yVT1P80wlf7W37BKCRH44zWZ?=
 =?us-ascii?Q?broSrJXjO/+Ql1fGblC8xoa2IS5JJu96C2LWH8tA0Cvqtlwcj79kBmxoXMs/?=
 =?us-ascii?Q?yWSJYNum//WUKigh1Auj976u2lc2lJ2oyED+Ezk9ThI9WKMI6iP5LJRda0UH?=
 =?us-ascii?Q?DzgMSFFCwA8jBnWFUmYxvVRMhqWfj1sr4PYxGkuPH/G78L2NmOHO0mCNtbOS?=
 =?us-ascii?Q?bJzGp7nCK/yoNSBtV1ek6eoAGh5q2TYQUcXE9OcdIOn+qFlqRcyNGfUaD5Mi?=
 =?us-ascii?Q?wk8XRANpq8M9wjAajYrHE4UUuwoxRNfDTxogg0nEDJaFMU/GNI2Slz2OyKO5?=
 =?us-ascii?Q?qFxsgxJ3soMWGyFZDGnKrTR+fBZpiYVIBgI0Y3w6wivV2PRcLho6fd52DPfE?=
 =?us-ascii?Q?n2KN0sm5ssVmxz/L5AXKCVXKhn5BKjWRZZmFyfmw8oAbNHEG5G2czQJviW0R?=
 =?us-ascii?Q?CfIIs5l+0CyqVAfw6kH1ltK5Ey03LeALeVgsRuqP9UwDWAI1NNChOFtXP8Lm?=
 =?us-ascii?Q?EruIfwp3Xs+3cJDYSNhazrj/XKyczdWYqIS2dhABIRgXaOeiQ6+HCo/gEhJG?=
 =?us-ascii?Q?JP7f6xOZIraqxTR3zZ31ubJ+r4eR2thZKFux/EoHACw8P2Xjrf3TsanZwt2y?=
 =?us-ascii?Q?ONyvONXyD2wJZlpvlBevvTgX+GEKxu6iVZq78UourhFzuoqdFiwtsjMUIETZ?=
 =?us-ascii?Q?seXvnPmwYiIriWltwuase+4gPYIia4B6g0wkTM9p4nw9M2v/oZmBv2UZit/S?=
 =?us-ascii?Q?+2SezCsydqkme7ms2Z3aCFtUkvmlni+pySWMMCprhQSORMghNQnjFWho4WRk?=
 =?us-ascii?Q?/5vWWHwZw/oAjlqc4va8b3DfGw0AU7M/Bj2ffSuYXUGpCjP4wimQw2EhwjsG?=
 =?us-ascii?Q?1RVimudjX+XdcpPzisS2725cwVIfQh2X93djqU/yhJmdgzpA5V4kTy8lRHEf?=
 =?us-ascii?Q?P+ewKP6kHnA1Dys1izX4cN1yTmwUhOvx2g0beSIJJa8idoet/EZ4nAQmJ4JN?=
 =?us-ascii?Q?hBsiFRYhlNmcMVt7A+5hwxVpC+FImMj/nOj/KHokRtFV+TJQDaCzY6TVWCSx?=
 =?us-ascii?Q?mFPBFkCdYBa6Yqxq335fa7LgfCu/IaN10V7sXkwZXIDy5yzKxgpGtLgwaIt2?=
 =?us-ascii?Q?3j7Qemdfz+H2ZaLEgmtNQ7JofyMO6F8cqrRXnhVD4NMFUAHfreDf7U8Ov4ci?=
 =?us-ascii?Q?q/yR3xhsJaYxrLsjq++4ox1ycaGTGUZv2PCNSbgHWCPR1PcUZeTHT2DnXBR2?=
 =?us-ascii?Q?hcb8BgMXW2xqSrh482janG3UoOb07gtwXLL3O9BOmbRxmQCb98IsN66mqCKK?=
 =?us-ascii?Q?wSW9/lOYwwlb5uUncCNUppjgAAOhoW+H0HRCJk4426PC4ZE7S9aRg6t+6OKv?=
 =?us-ascii?Q?6tum3f9mn8SRjeK5iwXXejjwHBgo7lMyi8H+QYXExQx+Ig19M8GzEBt10qWL?=
 =?us-ascii?Q?XQlaJZ/Zax0CaK6p275HlvJV8gKphssZ/TpbQ5zC6hConDQMnx4NoEKbFlGn?=
 =?us-ascii?Q?7SgtzGTFbVOYBH3oFvQ51OYw/sK5Cufvak2TOYiN/dfE9aX37tqLHFi6CQhV?=
 =?us-ascii?Q?JTYPF6KRpIEMFgw51k/J+3bdON3XguYYUIJO78N4rWNMhBn49Gy+WwacD6V+?=
 =?us-ascii?Q?iVlDUL6FYF8WVAu9ntzETHsq64JvpvzjUMuDg3ToKOR7sF82g+tNYWzjpCJo?=
 =?us-ascii?Q?nz7rDXm9UNaljc7wMSyBFAxr9BcWVvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200510fc-8b58-4628-0a63-08da430819f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 13:18:50.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZhDt690gphqVc2ArNe1wAZvRq+bGW202hJwZ7lzl8P4kKJHDKvnOjo+0RFPWUGch+PeAZxqWTuJ3O4ir7amRqF2KPhjLG4wDCTJToiE5c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1287
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> This driver already has code logic for WRITE_SAME, but was never working
> because of a bug where WRITE_SAME is disabled at scsi controller level.
> Apparently if WRITE_SAME is disabled at scsi controller level it takes
> precedence over disk level setting. This patch fixes this bug, and enable=
s
> this feature only for VMSTOR protocol version 10.0 and above.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ca35309..3e55687 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -50,6 +50,7 @@
>   * Win8: 5.1
>   * Win8.1: 6.0
>   * Win10: 6.2
> + * Win10.1: 10.0
>   */
>=20
>  #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) |=
 \
> @@ -59,6 +60,7 @@
>  #define VMSTOR_PROTO_VERSION_WIN8	VMSTOR_PROTO_VERSION(5, 1)
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
> +#define VMSTOR_PROTO_VERSION_WIN10_1	VMSTOR_PROTO_VERSION(10, 0)

As you and I discussed offline, it's a bit weird that Hyper-V is using vers=
ion 10.0
here instead of the expected 6.3, or even 7.0.  I'd like to hold off on thi=
s patch
until we can clarify with the Hyper-V team whether this is as expected.

Michael

>=20
>  /*  Packet structure describing virtual storage requests. */
>  enum vstor_packet_operation {
> @@ -205,6 +207,7 @@ struct vmscsi_request {
>   */
>=20
>  static const int protocol_version[] =3D {
> +		VMSTOR_PROTO_VERSION_WIN10_1,
>  		VMSTOR_PROTO_VERSION_WIN10,
>  		VMSTOR_PROTO_VERSION_WIN8_1,
>  		VMSTOR_PROTO_VERSION_WIN8,
> @@ -1558,7 +1561,7 @@ static int storvsc_device_configure(struct scsi_dev=
ice *sdevice)
>  			break;
>  		}
>=20
> -		if (vmstor_proto_version >=3D VMSTOR_PROTO_VERSION_WIN10)
> +		if (vmstor_proto_version >=3D VMSTOR_PROTO_VERSION_WIN10_1)
>  			sdevice->no_write_same =3D 0;
>  	}
>=20
> @@ -1845,7 +1848,6 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost, struct scsi_cmnd *scmnd)
>  	.this_id =3D		-1,
>  	/* Ensure there are no gaps in presented sgls */
>  	.virt_boundary_mask =3D	PAGE_SIZE-1,
> -	.no_write_same =3D	1,
>  	.track_queue_depth =3D	1,
>  	.change_queue_depth =3D	storvsc_change_queue_depth,
>  };
> --
> 1.8.3.1

