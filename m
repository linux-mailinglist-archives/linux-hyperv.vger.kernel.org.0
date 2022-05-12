Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8705250E1
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 May 2022 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355404AbiELPIg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 May 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352937AbiELPIf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 May 2022 11:08:35 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770A21B0929;
        Thu, 12 May 2022 08:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie4d6xLClA7Q69mh/RY2z9pjk6X8YjIB5oX+qQo2mMuwdJZF5ijb+KMV6FW89F14s9UbSOLeQxypIp4w8n2+sy9N8qOiuLFs/Z1HQKTvIFSKLZXQsdYazaHivAIS+JHy8zz/ApNxwnXfVXdyN07D7HjoQSMAlubF2vkGKpWqrdQPVJ4XBjlNVYOXdfWVnME++R3NOgEOBZni3WKKqn05aEQkeqkkbepDmOwHL1jfAyKT5GSROy1pwK4jD3WkBYPXt6ZQQ9oZuchkn1frSYyo6mg2qH6xoqmm0x4eQxJ3ueq8bzYnRMljJifXz4Ex8dZ6HRJOArtnf0WMmlRwpMmj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsCaggoYv8oI1OcHo1WMenc1EIh5XdJwDyUe0+Fat7M=;
 b=EAnpjs7UDjmRxIHYZ1MP6Q7pIhaKQbtQoXupnO//G0FW8qBKZtd+Uxj99EVTSrdLJuCCuZ7MmtcloAp9/tF/GWKqNeu2K7fguQ/7ZNzlaaduUT9ssoQ3y4NlCXNTE94AOStd7xmnIX4gRsDspWEO/rdQQnDZ3gg2o/NkkpOdlMfKPUWue93u0f5OUcd+siK58pGqtzqYDfhaEwMNQtfGYQZzTnSuIKpGz62Vvlqqr+su+u4w2pLMWZLc5DJAZqHVwfdq1g+O5Jvkkgg/XrLrG8Fi0nyL8wUPLeGIM9W4jy5kCDKOU8TsYseMFmAn5VEnToq8ksZvipkaO3vdMMVFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsCaggoYv8oI1OcHo1WMenc1EIh5XdJwDyUe0+Fat7M=;
 b=JjdM9jJegfdlrhbbdOuHUjIqN8EskN+mFB9NmwcbVTgESxQETe2ObUFto2DNVtsgmSVQ1/cFqSyDDRhdBFEZ5AC9M60QW4TrCC40OZfdTDLHfmSwrb0/kSINJpI9TUK5hUmUt8wUWoBC9ZBBy5qHm9AFKsVl/GhfX7lTUYMf3PM=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB2032.namprd21.prod.outlook.com (2603:10b6:510:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Thu, 12 May
 2022 15:08:29 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%7]) with mapi id 15.20.5273.005; Thu, 12 May 2022
 15:08:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] PCI: hv: Add validation for untrusted Hyper-V
 values
Thread-Topic: [PATCH v2 1/2] PCI: hv: Add validation for untrusted Hyper-V
 values
Thread-Index: AQHYZYcAaXhxM5JNcUufOEzq14TQAa0bWMyA
Date:   Thu, 12 May 2022 15:08:29 +0000
Message-ID: <PH0PR21MB302562C4833FA2A1E6F97CC2D7CB9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220511223207.3386-1-parri.andrea@gmail.com>
 <20220511223207.3386-2-parri.andrea@gmail.com>
In-Reply-To: <20220511223207.3386-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=392705c7-1670-4704-b753-ca9c04c000fe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-12T15:06:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dd5bdf2-b2eb-490c-8a5a-08da342945c9
x-ms-traffictypediagnostic: PH0PR21MB2032:EE_
x-microsoft-antispam-prvs: <PH0PR21MB2032537CAF6165E1D82CC73AD7CB9@PH0PR21MB2032.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YduW0axstcIxz0qMGKPKi+CtSmvAW8jg0MLQQnYGceQMGmFPdC1SMZO+unTafAsVPkhEBgOWbkbLk99ZU7PwReW97eY1iiUWfFa90kQnf3uiFIbQX0an06NcO3AmYSQeX/+lCP0U8fT8kV7z0mMIeZisuT14fd/6t8X98Nn9zB+jSUhCgrFZ5/VZIPm6O/5LLJ7qu8E4hKsCjvbvb7kaiBwxld85ID9FeS1/HvSk+iCMHCNsQ/HeAodGenW3MTTIxgEk9mH7qqsw3YKhPIkDIVTa4+QrH7oFW0jI76wDBbXo/B71T7rCOwL2IPiOBaRlCC6G4Ea87sMzWiNgJv0E6rZ05GXlhAQQB/DOO06Vct+EsfkXxDsBvHqy03pauL6xY2OZ+BQWFulbjE9/THG2VM80kmWJdKY/mWNedRvSQCbmQVjsJqDUyfX4ql6hQGnxKs0x1I0/qyPtPwTlwnGZW5ij8LFRFEvLICG0TNzYh79hpHW4gUrEY5djH+NGYOyzJ6fOzEAWZrMwihcIZsxybUv3AI9iuUGgCOjlLy8O5NdSPZI90TvQnUFsRo7LuXKcFe4FdE8ScCsd1LUicoKgW82Nq5+Zw80sjdcfzmM/klHd2NB1z1+9yArPrn0ER0zQLt4WLFUtmhfzttpO4pneQ58JmDr2Wsesi+Y+lv8KBCoLJNB/6PeOmW6refiBTHXUZrzZQNAk3x2EsNmBz2Kvi+1k4cE0aLMDtOV8kjqPn/3lRhmsgem5hy/oJ2INnghfGmecSPEWOWqz1lOucCS3sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(82960400001)(82950400001)(38070700005)(38100700002)(7696005)(921005)(2906002)(5660300002)(10290500003)(122000001)(54906003)(316002)(110136005)(6506007)(71200400001)(83380400001)(4326008)(66476007)(8676002)(66446008)(66946007)(66556008)(64756008)(8936002)(33656002)(508600001)(8990500004)(76116006)(186003)(86362001)(52536014)(9686003)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4UVVVuNKZ5Ph0b1X66gzKTGjFQtZDXg9dhigwDexPRkKiOYjaxC5Ea7/KFT?=
 =?us-ascii?Q?7cuKJS/fsa0CoCfrvmu2MniewlMiP6UNQEoFo9T77EIwaWXXxGapxFTcVORJ?=
 =?us-ascii?Q?CB8bP/BZtZ8bi/4bx7vPuIRI3JI9cq+giVLQPMvY62ULzWW4N/PMBKD5wxgV?=
 =?us-ascii?Q?Yj5NJc/70epExdWVLmeRLk7+tQJLD0Ef5CyIqYqCbbQPoqF48z0oM2VA9eJ0?=
 =?us-ascii?Q?XZJf4y0oYUcEEtXQSU4L0c9GRV7LRn4IFg+cDZSUkgsukbX0iMwngNKHprK7?=
 =?us-ascii?Q?Ts9QKtOcpVGBxNiqJ3cUj68BZP8jcdgcCKjbp0VxN//mxNgaWpNOf/26UWVx?=
 =?us-ascii?Q?N5yijsl/dtMlDNVo38fWbJUwPjGAyjsVjwse4DRdL0/WFbDkXuBAhV+9S3Vx?=
 =?us-ascii?Q?8FPjyJRi0osfJ+gO3L2m1prRxseQyMif90+kbnlN3Be5GvP0GuokRw+ZncP1?=
 =?us-ascii?Q?IdgQLX5afoufhb4xMllxlJZWv8qQkACIVgF8fV1Vxq73ySoRWWsSuEAHuGxM?=
 =?us-ascii?Q?3D2otcUoHhnPbRB8m3J2Vy6Ev2spkRuMb1plKwRmaWomBrKsuIJ21wufnJcD?=
 =?us-ascii?Q?TYC1hJ+/xZANojx3QboPElJr6lgFZ08DHf4YesINh5k6OMU3CSFhonOAKMfB?=
 =?us-ascii?Q?snxU6bL2EM1NAWBvJpl/hUexuHJhXoCbx6J/pvB5t94KsYl6tHwrgkehDSn7?=
 =?us-ascii?Q?blXOdb91RVsxSMU93qxgPj/6Mjq7GdNsVJHTe3FYiVRipU1N4y4NlCjkZxuL?=
 =?us-ascii?Q?Xh94h9qt52yJehv407FOAnOsou0t4toFRTmgsaviUSt8GXr9ZVjUelEmGIwj?=
 =?us-ascii?Q?ajWjAKOAR+9V1w4znUkFESufjenLhUCTgu15XASu+ZoSWujFD+PzeI7PxLtv?=
 =?us-ascii?Q?/e6tV0SrGdmxGmYADC4BJvhCiCd/YqvAZJhScIKNZjWnsWFcjBL0pNnGGKq9?=
 =?us-ascii?Q?ufDFlkjyRCtsc0xjrsqKdTETV5R3Qx6Qj3fqEQmclv1EY+Ez/C7AF5KsvTYa?=
 =?us-ascii?Q?UyBBYTVfNor+MoK9xZ2+wrixRVfsoBu5v41NTgLgsYiMFyXsR80KneCG5EDS?=
 =?us-ascii?Q?3AnPoBlucE/4VgBRQWnROrpxfuATgGpxE2ieu4qHsG56gUVSIdRv/40afDI0?=
 =?us-ascii?Q?tQMjCxb9erTNQFV5GMvwtc5Bk9B+Opl64wc77ivDP/guPhGSQLU7gifHW0TY?=
 =?us-ascii?Q?5/LXHl+Gmnb3x33hdNiu1qPI9Ly2RUwDrsVTIo1fNAnEJ5rA5k4JNjPLS68X?=
 =?us-ascii?Q?M0HMsJYPeMqIodbxGuC0mFk1xhNeEUWW/HCKWBIWjM87mfFJ60BHMU4f8/f9?=
 =?us-ascii?Q?MHzhec9C5dD6OI781dbPg2GlaTuvCcoqh14VvGmv1V5NStYMhkITvOPgXf32?=
 =?us-ascii?Q?OTrL1M3zwBWB07LeWYwPR+zPfSmCqZmtscIxngpZasR4lKyoLFwN7lF/FdhT?=
 =?us-ascii?Q?dayoRy3c6UEQ28EkxN0OwKFMLycP5f1T7VGPdR8b0QJ0/Ltaeyp4kSiWoDK/?=
 =?us-ascii?Q?o3QGTFZy1yciVhm2pN1LkWRO8e2qNEsKjFyeQHR3a004XL7W30ZLeAlJ+Pg+?=
 =?us-ascii?Q?hdU8ukqE01P1BrAYBARKCvxyETMl5/WsUaoKged5iUG9SfbCuzSXL8YD5Q5P?=
 =?us-ascii?Q?AlA+e1AXJC+XKYNmo+4WnlTzaLtRVPAaYkUTdobe/FbY1qETnKLuiBKKoJwD?=
 =?us-ascii?Q?ziRAg7S49I+QJcuOj4tdAY0t6frDQXphKQNHihQiZimn02Jb8UILRU6foLzp?=
 =?us-ascii?Q?MNgQD5HvmzPgMG1REOQ0TSUmqFATx98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd5bdf2-b2eb-490c-8a5a-08da342945c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 15:08:29.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaAnoU3fsBV2e1ZaX/V2kZvy4Wb5e62+wR/PAUM4UaeiCWji0blowOIE2qjU/FaicWjp+cDamhzAeYOL1I29UQxiJx+u56MUXErvq0ILaVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2032
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ma=
y 11, 2022 3:32 PM
>=20
> For additional robustness in the face of Hyper-V errors or malicious
> behavior, validate all values that originate from packets that Hyper-V
> has sent to the guest in the host-to-guest ring buffer.  Ensure that
> invalid values cannot cause data being copied out of the bounds of the
> source buffer in hv_pci_onchannelcallback().
>=20
> While at it, remove a redundant validation in hv_pci_generic_compl():
> hv_pci_onchannelcallback() already ensures that all processed incoming
> packets are "at least as large as [in fact larger than] a response".
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e439b810f974b..a06e2cf946580 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -981,11 +981,7 @@ static void hv_pci_generic_compl(void *context, stru=
ct
> pci_response *resp,
>  {
>  	struct hv_pci_compl *comp_pkt =3D context;
>=20
> -	if (resp_packet_size >=3D offsetofend(struct pci_response, status))
> -		comp_pkt->completion_status =3D resp->status;
> -	else
> -		comp_pkt->completion_status =3D -1;
> -
> +	comp_pkt->completion_status =3D resp->status;
>  	complete(&comp_pkt->host_event);
>  }
>=20
> @@ -1606,8 +1602,13 @@ static void hv_pci_compose_compl(void *context, st=
ruct
> pci_response *resp,
>  	struct pci_create_int_response *int_resp =3D
>  		(struct pci_create_int_response *)resp;
>=20
> +	if (resp_packet_size < sizeof(*int_resp)) {
> +		comp_pkt->comp_pkt.completion_status =3D -1;
> +		goto out;
> +	}
>  	comp_pkt->comp_pkt.completion_status =3D resp->status;
>  	comp_pkt->int_desc =3D int_resp->int_desc;
> +out:
>  	complete(&comp_pkt->comp_pkt.host_event);
>  }
>=20
> @@ -2291,12 +2292,14 @@ static void q_resource_requirements(void *context=
,
> struct pci_response *resp,
>  	struct q_res_req_compl *completion =3D context;
>  	struct pci_q_res_req_response *q_res_req =3D
>  		(struct pci_q_res_req_response *)resp;
> +	s32 status;
>  	int i;
>=20
> -	if (resp->status < 0) {
> +	status =3D (resp_packet_size < sizeof(*q_res_req)) ? -1 : resp->status;
> +	if (status < 0) {
>  		dev_err(&completion->hpdev->hbus->hdev->device,
>  			"query resource requirements failed: %x\n",
> -			resp->status);
> +			status);
>  	} else {
>  		for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>  			completion->hpdev->probed_bar[i] =3D
> @@ -2848,7 +2851,8 @@ static void hv_pci_onchannelcallback(void *context)
>  			case PCI_BUS_RELATIONS:
>=20
>  				bus_rel =3D (struct pci_bus_relations *)buffer;
> -				if (bytes_recvd <
> +				if (bytes_recvd < sizeof(*bus_rel) ||
> +				    bytes_recvd <
>  					struct_size(bus_rel, func,
>  						    bus_rel->device_count)) {
>  					dev_err(&hbus->hdev->device,
> @@ -2862,7 +2866,8 @@ static void hv_pci_onchannelcallback(void *context)
>  			case PCI_BUS_RELATIONS2:
>=20
>  				bus_rel2 =3D (struct pci_bus_relations2 *)buffer;
> -				if (bytes_recvd <
> +				if (bytes_recvd < sizeof(*bus_rel2) ||
> +				    bytes_recvd <
>  					struct_size(bus_rel2, func,
>  						    bus_rel2->device_count)) {
>  					dev_err(&hbus->hdev->device,
> @@ -2876,6 +2881,11 @@ static void hv_pci_onchannelcallback(void *context=
)
>  			case PCI_EJECT:
>=20
>  				dev_message =3D (struct pci_dev_incoming *)buffer;
> +				if (bytes_recvd < sizeof(*dev_message)) {
> +					dev_err(&hbus->hdev->device,
> +						"eject message too small\n");
> +					break;
> +				}
>  				hpdev =3D get_pcichild_wslot(hbus,
>  						      dev_message->wslot.slot);
>  				if (hpdev) {
> @@ -2887,6 +2897,11 @@ static void hv_pci_onchannelcallback(void *context=
)
>  			case PCI_INVALIDATE_BLOCK:
>=20
>  				inval =3D (struct pci_dev_inval_block *)buffer;
> +				if (bytes_recvd < sizeof(*inval)) {
> +					dev_err(&hbus->hdev->device,
> +						"invalidate message too small\n");
> +					break;
> +				}
>  				hpdev =3D get_pcichild_wslot(hbus,
>  							   inval->wslot.slot);
>  				if (hpdev) {
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

