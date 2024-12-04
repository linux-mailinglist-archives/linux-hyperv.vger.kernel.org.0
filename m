Return-Path: <linux-hyperv+bounces-3395-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B569E3BA0
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 14:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA36B35A24
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527521BD9C9;
	Wed,  4 Dec 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEzESmK2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795A1EB2F
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Dec 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319935; cv=none; b=Xnhoj+NmBCBtigikwZaUfNRn6GEUN8UkSZhQDHMwRk2/fOWZy7jVCb4S4Mcb3jQ4Aa3qEXyQcWcBNWx0nVuF8tCd+miUFifCl3x9ORqw+M63p9uXoehuaZPWWlA8Eq6z9Dzn9f8b/p/qeQTTU5vKgm77lTriCaW+7X8OyVqfvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319935; c=relaxed/simple;
	bh=x7Zks2UUvhFqsbG7mkkKJv6OfEMFvfDACbsVK7TrU8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNLNd37uReZpsaz/K3riZe5rJYcSqtHBg+kj9n/VNBfw2a7eXM1rpbC5SXxObbQV6apTpxtH/5COuojdpeYNL44XQpZBmLhP7myOEpSJD1S2jUT4eOKvwCpX7LWASFkmoGVa8D8Kw0p0SJ6k/VtM53W0OLLmrtjT2BCb6Lia5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEzESmK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733319932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfzsMKSDpksu1Ik71I0LavlaD/4ezjHXC0zfA3/Wep4=;
	b=XEzESmK2wDAG16TeBuiPYNpu9OrGFL3GZX6dUBmR7DTFORWXLFyBr/K5NY+xwbacbwPnvC
	1lE2Up22oR263S4G4vGlEFXkW7E7k0B5LtzLt4h4t64YfIJyW/pIWgyJxEOVZd219tcj+C
	ZKA07QLkIbJyGaxtcPbCd6zC8ZrRt7c=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-c-18uZ0OMaOac5W4CxXBDw-1; Wed, 04 Dec 2024 08:45:31 -0500
X-MC-Unique: c-18uZ0OMaOac5W4CxXBDw-1
X-Mimecast-MFC-AGG-ID: c-18uZ0OMaOac5W4CxXBDw
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6eede4788fbso112002877b3.2
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Dec 2024 05:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319931; x=1733924731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfzsMKSDpksu1Ik71I0LavlaD/4ezjHXC0zfA3/Wep4=;
        b=CdgGWH51AEy4tBRWsMY0suFxR2DjZGfsACjzjsh2v3Ozh32r9XZ/iZB0CG/Crfdf9L
         0mggZUaxq+cuYLbY3x2WSkJXd2uhK44dHymp/WsAF4pph0L0qjN/iF9fd/RUnnkaBsyx
         ZzDiR89DoEm7Gp2tRSPm/bxSFs/GUaopJM/CFq7v46pWirmS4GQ2CQIkIsGUOzcs8Cfw
         wvxx7ttVrcEuCFw9cMijewpD/P/0KK6Ld1RG+6LS+9rvirBVXj/iM3OAwmqSKlcLgEtt
         gdzhHWuqYddi+yoVcTaJVyMy8yXaRpWxf1uzUKyVPtri3VTWeHWK8Y5n3cG/lkk+KCoq
         6Qkw==
X-Forwarded-Encrypted: i=1; AJvYcCVdTBWjw7zeS7B33j5slP4IYgd7YjUfPWSEfAN6t1ZaaXWzEaA2LAjExoC7FV6VqBsixUrxOlNv09/uiuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYQ92DcypoLzdEJEZ/LAehrzyA5lC3fS1L8nDj8YsOe6zT0lt
	/2AIkLSAM2bLCSh8ikty4/WqVjzBfDwStKWyiH6+2cU/YEWcqlPJ2SBxudg/eNohZqjPjlJx/Mi
	lu6czxl8o4KoZKiEAuWNPmT9vj+1TGlPCFpOcJfBB13IbwlPlsA2/Kb9BzYhPCm9FfMZjAfSoQc
	kyKSSg2NERnSQKRNnTb+6Z9wJzDRMJRAjhfWDB
X-Gm-Gg: ASbGncuwsP9I4B9MnopAB1LlVK41L0YD1rU7PlDql9lyZQ8P3z1/JS3qABXEzfp4MG8
	gAmCezaWa6xP2ovGn27XRgpVh3Ezuhrs=
X-Received: by 2002:a05:690c:4a10:b0:6ef:61b9:e003 with SMTP id 00721157ae682-6efad2f6fd7mr88309197b3.36.1733319930677;
        Wed, 04 Dec 2024 05:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJh0JveXBGAfwCZPJXi92+8eFnpI5egIrMgPNGfFHIU7y+Wx98MO5YLZnKgkY4y96eHhMCpU6SnKNxWYBd6Nw=
X-Received: by 2002:a05:690c:4a10:b0:6ef:61b9:e003 with SMTP id
 00721157ae682-6efad2f6fd7mr88309027b3.36.1733319930450; Wed, 04 Dec 2024
 05:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127181324.3318443-1-cavery@redhat.com>
In-Reply-To: <20241127181324.3318443-1-cavery@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 4 Dec 2024 08:45:19 -0500
Message-ID: <CAGtn9rncdvYQUGYVZwePccEGOnAc0FU1s5GJ6S3PSgpc-1OfPA@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: storvsc: Do not flag MAINTENANCE_IN return of
 SRB_STATUS_DATA_OVERRUN as an error
To: Cathy Avery <cavery@redhat.com>
Cc: kys@microsoft.com, martin.petersen@oracle.com, wei.liu@kernel.org, 
	haiyangz@microsoft.com, decui@microsoft.com, jejb@linux.ibm.com, 
	mhklinux@outlook.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, bhull@redhat.com, 
	loberman@redhat.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:13=E2=80=AFPM Cathy Avery <cavery@redhat.com> wro=
te:
>
> This patch partially reverts
>
>         commit 812fe6420a6e789db68f18cdb25c5c89f4561334
>         Author: Michael Kelley <mikelley@microsoft.com>
>         Date:   Fri Aug 25 10:21:24 2023 -0700
>
>         scsi: storvsc: Handle additional SRB status values
>
> HyperV does not support MAINTENANCE_IN resulting in FC passthrough
> returning the SRB_STATUS_DATA_OVERRUN value. Now that SRB_STATUS_DATA_OVE=
RRUN
> is treated as an error multipath ALUA paths go into a faulty state as mul=
tipath
> ALUA submits RTPG commands via MAINTENANCE_IN.
>
> [    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
> tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
> [    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752
>
> MAINTENANCE_IN now returns success to avoid the error path as
> is currently done with INQUIRY and MODE_SENSE.
>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
> Changes since v1:
> - Handle error and logging by returning success as previously
>   done with INQUIRY and MODE_SENSE [Michael Kelley].
> ---
>  drivers/scsi/storvsc_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..d0b55c1fa908 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -149,6 +149,8 @@ struct hv_fc_wwn_packet {
>  */
>  static int vmstor_proto_version;
>
> +static bool hv_dev_is_fc(struct hv_device *hv_dev);
> +
>  #define STORVSC_LOGGING_NONE   0
>  #define STORVSC_LOGGING_ERROR  1
>  #define STORVSC_LOGGING_WARN   2
> @@ -1138,6 +1140,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>          * not correctly handle:
>          * INQUIRY command with page code parameter set to 0x80
>          * MODE_SENSE command with cmd[2] =3D=3D 0x1c
> +        * MAINTENANCE_IN is not supported by HyperV FC passthrough
>          *
>          * Setup srb and scsi status so this won't be fatal.
>          * We do this so we can distinguish truly fatal failues
> @@ -1145,7 +1148,9 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>          */
>
>         if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
> -          (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE)) {
> +          (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> +          (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
> +          hv_dev_is_fc(device))) {
>                 vstor_packet->vm_srb.scsi_status =3D 0;
>                 vstor_packet->vm_srb.srb_status =3D SRB_STATUS_SUCCESS;
>         }
> --
> 2.42.0
>

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


