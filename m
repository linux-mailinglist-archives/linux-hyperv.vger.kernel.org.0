Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E139E982
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jun 2021 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFGW1I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Jun 2021 18:27:08 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:5028
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230291AbhFGW1I (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Jun 2021 18:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UziqkNUU2W9Pektz8YFQlYFpzTwmLnSzHsFKAPqmq4G1z2QCAJ+r+uiKWpmnbiHtzJxBUBYg9K3sW6GFwfMqakQ1/HEftnrtA/hmcZrqLRDmjRnn3lQk9eAzGqkSu3TQgOqA2fDcp1XqOR3KK30yFrlkaJFKd0IoUKe5YBiwdT70+94m45NWv9mwEGOJ/VWpGYz9SIHMOadZqprpIB/GQu7vttD+Aji+kyupbYjVwhQ3UBBKZh7yKGtM6k9TbxEKhQ4ghasoX/UZ71Z/1yhOsgIfnneF0dVAR3kRfUxSJqwEMo1V1Ib5HqT0/GIt4Fuklsb7tAMv8yo5thw7UjIvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dZcfSeVnpftRoikZPVr8lys0JUpVgwGZhxqtBN5HEw=;
 b=f3OAnbR71xIPqEFaUySOfmc9IHPT2BmS3FY24xxJorAIY3c42Swnf0Os5XIy3SLmfRrJcDvD8ac9dzz3ntd2VGiCAG9ybMNf9vxVBE9Swr2PnsdzU1lFSR8ddNssKusBBbnyfN0NYrujLNfWM79ZQmXjCcGZAd2vSq44B2VlRbZuHv2davoWt/CV64QuQx3BGGinLEAWC/Sm7v7uzhmJDyZ+6YvHWB4cnAruZ10I+hG4vZJH2FjBeUVh0ZhkZ7uyVgpFSOWeOiF+3E685bLo5duAfIxmrMxjVG709XsEnVzG+6i9S4ia+W9DnSOV+/ZxweY+dNaSdPxM94uB0vzOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dZcfSeVnpftRoikZPVr8lys0JUpVgwGZhxqtBN5HEw=;
 b=E/gOGI8uv05CrHNyf3pC9S6CNlEWiLS90dtCoYg4Pctch9YygUdPXcnvmIM0P+0f72KdXnG7DUB6XxjS4FDHdWD9sM1pr4E/8RQDClmc5UKBIXH6XXE8SXRA8KPvo4B8MHbTW0Ayrls0nQ1fKsIMA5DKar8eT4OFnZudMvixaVo=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1952.namprd21.prod.outlook.com (2603:10b6:a03:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.8; Mon, 7 Jun
 2021 22:25:13 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::29f3:2078:6dd5:33b5]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::29f3:2078:6dd5:33b5%9]) with mapi id 15.20.4242.008; Mon, 7 Jun 2021
 22:25:13 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 3/3] scsi: storvsc: Correctly handle multiple flags in
 srb_status
Thread-Topic: [PATCH 3/3] scsi: storvsc: Correctly handle multiple flags in
 srb_status
Thread-Index: AQHXWWYJBC+FGvD/uk6JAw5xaFOYV6sJH7mg
Date:   Mon, 7 Jun 2021 22:25:13 +0000
Message-ID: <BY5PR21MB1506CA56A8470892FA0952A9CE389@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
 <1622827263-12516-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1622827263-12516-3-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cc0d189-a83b-498e-88ab-ea7c01acc869;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-07T22:05:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 869e790f-2c17-47bf-b3b6-08d92a031ebd
x-ms-traffictypediagnostic: SJ0PR21MB1952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR21MB195269E302D10CE9EE596C61CE389@SJ0PR21MB1952.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yv68c8aZfrMPoyA38tb5LPzeEt1eEE6j4kqBfDHKtLx0UmZ8sozwQbIMpQSWcFPyYke2ZyHFmV34DXFfnM4wWQT26rY4RF36OMzOFXDrqFYr128/XF+29T/qCFY72VkwJDR/0r3JptdWGVRGVi4XOYGgVgU1eNwTe5gZkCAtTGrilyLG3N2yRVGcIt5lD77YSoeai5gxUrDct924k8jgftJRn5H6l7UPrStBuDoYM3V+/wAedGNkLYpTnUTZXoDzKEdYFR8dNXhdDt9kPewHAUoxnIA1f2Ma7pYE2NJmM3rGdcGH5J7LVYI3ts2hG9KEZ2Bu0pdSFOypbNEC4ld+5f7Ujndo70tqrayYu8uVuRuYa3fppp7lqbz84a+t4v5P3bqYee1Ecimp2yBKgbZZm0njm28bbWOW5wq2S3IgZ5dehdbM/VMl37v1lBIEJHUB85v8N45XjuF5Tzd6ghBvwYN8o2qM5s814NEPW1LoYGmN3gAw6lY9ARPmZHyZAVSTngB1ZJlBOEK5lzu90stvfhIb1E+esUZ9i0J0CK6uuOzcBIKapmoTU+u3SMtIyPzVpANGnmMgXh7vGZEdXS+CG/vSd/zaWXi+poOTDIQu0soeJRfgI4cLqD7DmJwjqGUT5IzGBLceIEwyVzbAWYgQeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(110136005)(316002)(6506007)(186003)(38100700002)(122000001)(82950400001)(10290500003)(26005)(52536014)(8990500004)(9686003)(33656002)(7696005)(8936002)(8676002)(86362001)(83380400001)(64756008)(66556008)(66446008)(66476007)(82960400001)(5660300002)(66946007)(76116006)(71200400001)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?By/2lyqFM2+orFUJOwIWqMZGvWADH2Ig7h/ygFYueh7J7cF+apqxtcRPTZTU?=
 =?us-ascii?Q?/6MZ4TpMVIZXfy5Xwy6uLm6cgTeW3hItQjNUoD2C9JYA1OSf9NZr1tYanSpo?=
 =?us-ascii?Q?QGsHx8w7I7Jqrjgd2ObhyVlAjhMNzl1pQ465lQ8HcrMRtRU2e2qvM45klPCh?=
 =?us-ascii?Q?s4nDm2tjdNJZZWL0hYvLawZlYHh7IuRWfvkWbmvKKAbTyFscAq/ktVBbl+Wc?=
 =?us-ascii?Q?qdnKt+EQ4fsJ5GSMtS9S6bvdOI85dktdbVgKOTy2nS35CrFej1eeqtFSdXVX?=
 =?us-ascii?Q?4lKgFHYgKfUqBYlXrYLdhTVUfxYVLgAcRizYkGjqcBcVtNwnzBGzQ+sVzSAH?=
 =?us-ascii?Q?BepnG20OvsSCmzbapuETkNgceVD6MRZQXSiNYpN0X6JqZtgnkaiTxctxyQi6?=
 =?us-ascii?Q?Zlqrejq53+Y5kNlpbXyJUfk6uiyfGeRuTMbqxBrM+X3D0G/4OKQL84ff7uYk?=
 =?us-ascii?Q?9v+THR/y8RXZh8BLvpCD7heC/z9+QnZTZ0bKb8GKlmHBoUE3P4L3PAR2AERb?=
 =?us-ascii?Q?gByJFBpQ8iY/o6Orwo3lejF6M7beitSXq0yu8ia0ayddkV7bXEpippymN4uW?=
 =?us-ascii?Q?HP4UxJzrkbLKy0DXJGxGN/gm/s/5h5QwaADguJISqcpVSE9TEKOFYkYJIfkq?=
 =?us-ascii?Q?DNnYOW653NaFifrnHUOK0w2emnp4Q6rdCljP0GA/Me56cjIXp+r+fwl0OWJq?=
 =?us-ascii?Q?p24da6KYksBNbrl10XxVRg1Zcg/HNSOgnls6nFQsHxViUhnMdCqni3ZqmNIH?=
 =?us-ascii?Q?rd4WZOPMsBt2gMAL7tYiZA0fD45ZegcALSLPa3ZTKFXK7JnW1kD0FMOzpl92?=
 =?us-ascii?Q?gU1Mb92ruWmADvDYZmzL0HlDUpe8AYbxsYtmxFguZdgwDRUfDLb2g2E4ggOc?=
 =?us-ascii?Q?TTh26Gbxu9YpoYJGgLD2cIQbL2TQ2bSCQrzc+Q779IuNfsZhIxUir4i1cWV8?=
 =?us-ascii?Q?ifONu8PVnUEDy5qI9HJvXxFff9GgyzBSSU+2Uy3eL6jBHUlyqVUUbX7WGYaC?=
 =?us-ascii?Q?8Gxw0Sen4Ib43Cyu2AqUcXYfjFr1TE1EsyxO43Ul82AOQsFDQliB3P6Suf9a?=
 =?us-ascii?Q?WGxYdBLOF91qGYb5o0H6H/sEJCxfdRA68PDnu71uiFnPHWP+BhFkuFJtgxLw?=
 =?us-ascii?Q?W896CXl1FXX9oX2jWzXeCYKZL+sllqMXh2pMswfB7PjbBDlspG/Cvm4PTgGN?=
 =?us-ascii?Q?UDTeqNtrqEXDFP9m642J/NUMbGsd1xSmxBnq/hX+jj+lVJREno034llSZDb3?=
 =?us-ascii?Q?7J9NeK/890b3OH4+xMJeErc2L9sSDSARacf6x4MWnJOTaalhwe9cl9/7gb3O?=
 =?us-ascii?Q?kT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869e790f-2c17-47bf-b3b6-08d92a031ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 22:25:13.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZG5Wbyio6HgVZ6P/yDWjqpzTsXbZcm69o5/zxwZrvwA9xhfQkB3xX8cZkTKwikKDKtMhskCQEMRqgCmnuP8bkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1952
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [PATCH 3/3] scsi: storvsc: Correctly handle multiple flags in
> srb_status
>=20
> Hyper-V is observed to sometimes set multiple flags in the srb_status, su=
ch
> as ABORTED and ERROR. Current code in
> storvsc_handle_error() handles only a single flag being set, and does not=
hing
> when multiple flags are set.  Fix this by changing the case statement int=
o a
> series of "if" statements testing individual flags. The functionality for=
 handling
> each flag is unchanged.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 61 +++++++++++++++++++++++++---------------=
-
> -----
>  1 file changed, 33 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> fff9441..e96d2aa 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1009,17 +1009,40 @@ static void storvsc_handle_error(struct
> vmscsi_request *vm_srb,
>  	struct storvsc_scan_work *wrk;
>  	void (*process_err_fn)(struct work_struct *work);
>  	struct hv_host_device *host_dev =3D shost_priv(host);
> -	bool do_work =3D false;
>=20
> -	switch (SRB_STATUS(vm_srb->srb_status)) {
> -	case SRB_STATUS_ERROR:
> +	/*
> +	 * In some situations, Hyper-V sets multiple bits in the
> +	 * srb_status, such as ABORTED and ERROR. So process them
> +	 * individually, with the most specific bits first.
> +	 */
> +
> +	if (vm_srb->srb_status & SRB_STATUS_INVALID_LUN) {
> +		set_host_byte(scmnd, DID_NO_CONNECT);
> +		process_err_fn =3D storvsc_remove_lun;
> +		goto do_work;
> +	}
> +
> +	if (vm_srb->srb_status & SRB_STATUS_ABORTED) {
> +		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID
> &&
> +		    /* Capacity data has changed */
> +		    (asc =3D=3D 0x2a) && (ascq =3D=3D 0x9)) {
> +			process_err_fn =3D storvsc_device_scan;
> +			/*
> +			 * Retry the I/O that triggered this.
> +			 */
> +			set_host_byte(scmnd, DID_REQUEUE);
> +			goto do_work;
> +		}
> +	}
> +
> +	if (vm_srb->srb_status & SRB_STATUS_ERROR) {

I'm curious on SRB_STATUS_INVALID_LUN and SRB_STATUS_ABORTED, the actions o=
n those two codes are different.=20

It doesn't look like we can get those two in the same status code.

>  		/*
>  		 * Let upper layer deal with error when
>  		 * sense message is present.
>  		 */
> -
>  		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID)
> -			break;
> +			return;
> +
>  		/*
>  		 * If there is an error; offline the device since all
>  		 * error recovery strategies would have already been @@ -
> 1032,37 +1055,19 @@ static void storvsc_handle_error(struct vmscsi_reques=
t
> *vm_srb,
>  			set_host_byte(scmnd, DID_PASSTHROUGH);
>  			break;
>  		/*
> -		 * On Some Windows hosts TEST_UNIT_READY command can
> return
> -		 * SRB_STATUS_ERROR, let the upper level code deal with it
> -		 * based on the sense information.
> +		 * On some Hyper-V hosts TEST_UNIT_READY command can
> +		 * return SRB_STATUS_ERROR. Let the upper level code
> +		 * deal with it based on the sense information.
>  		 */
>  		case TEST_UNIT_READY:
>  			break;
>  		default:
>  			set_host_byte(scmnd, DID_ERROR);
>  		}
> -		break;
> -	case SRB_STATUS_INVALID_LUN:
> -		set_host_byte(scmnd, DID_NO_CONNECT);
> -		do_work =3D true;
> -		process_err_fn =3D storvsc_remove_lun;
> -		break;
> -	case SRB_STATUS_ABORTED:
> -		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID
> &&
> -		    (asc =3D=3D 0x2a) && (ascq =3D=3D 0x9)) {
> -			do_work =3D true;
> -			process_err_fn =3D storvsc_device_scan;
> -			/*
> -			 * Retry the I/O that triggered this.
> -			 */
> -			set_host_byte(scmnd, DID_REQUEUE);
> -		}
> -		break;
>  	}
> +	return;
>=20
> -	if (!do_work)
> -		return;
> -
> +do_work:
>  	/*
>  	 * We need to schedule work to process this error; schedule it.
>  	 */
> --
> 1.8.3.1

