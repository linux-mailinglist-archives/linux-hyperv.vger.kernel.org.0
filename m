Return-Path: <linux-hyperv+bounces-9795-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKhiOcFexGkkywQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9795-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 23:16:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5432CD2A
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 23:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE1E63022994
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEC2F0C7E;
	Wed, 25 Mar 2026 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NauPbJ3N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694342C11CA
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476980; cv=pass; b=bAz6PNtPEqCHlCguHX6El0I6uzb7QR0RcmMmjxmfFQ+kPsUlm5Lu1MEEINIzlEB/gem43qS2CN5bKLVT5VeBC8o8hxd+q4uKaV+1US28VjzIZNSkys1HAXiSKKV2HgQKtNCVo0XX+W3DD14ZxBBZcteJ7JAzR3/LmZah6a01AJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476980; c=relaxed/simple;
	bh=CKPaPT6pFzg5mW5MbWk4jzTi2tnODuirpxJdAHgBJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLkd4jNb40nR7naxfmQ3uZKSQyiMsSlfvc1oM2F9VYnoFRDgV635NNcTOfvmnzm+tGDVCg1mNqEgv9shkkBH+pYH9j0KzZSktkfa7mzd0MzitvdOn0kxSuz3kuQZFPKaUyizfJfVxQRNG7Zjsva/h3WzYhfTVPD+sbnvDD5HgpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NauPbJ3N; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso182123a34.2
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 15:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774476977; cv=none;
        d=google.com; s=arc-20240605;
        b=QhQHn5EcyM1Yorr+Vjgo50oenQ9yYRGQWEUGiS0YP3l5ThCX4Dgr6gu1pv5yPleye+
         K2gPgZPTCgoSmgl8wa+pdA/Yu3Iwba6GQLIEqqgrOlG2O2OftLkioaS5N7gTQMjAY9ZY
         2JohItaUr6S81fkLSQrSHPydlT2JzVuWIXwD95H7XoXLLeaZssAMqvpFh2/hxTqlz9E+
         LFj4PG6M+R0jCjqNjMNp0dJVzlGbnqjNoiwdQHI8MPVr34wY2TScj0sZatsZ/vvNUMoK
         RedlfOLO1RBcCGoKYtGTMqeK/ekW5XJox04vckgxCAhEMV2SPbKlp6E1LcOIcqIklcDK
         SeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQDzQb/gBIw+MDDDjq7X4ZU1Rk6doOJDsa8UP6sNnoE=;
        fh=xvWU2gMYnBPHkUlRSA9PN0NWVOMg6Bd73R543QzKaO8=;
        b=BofOI48Cm7/emEm4+snWW9ctkvL11s7C9aEgIQtPSC7uFqd7WDc/w0CYgE1A9lZ+Tz
         nIQiURfElSYk8jPxe5tPqVGy4cgNNs44VJiKgCJDKiqafLW/gOvPgnThIvnfzt0Aacq0
         J+Mbd3MjDRjjYy4QPrONjR/hkJrzQyVeN4e24xFJD3Y0nNbHaXcc+CMmQotSigRgHK5u
         wvFRQ420dVKjEMiJABpDeyG24mD5vDaaagSE9dzG8m0wgHfxsi2Co/VBMiKgCZOKQA81
         HGWxTQZq+8GOizGEKT2GOFb6eG18C+toKgvNNFMywf1cfR5PI8xx+683EKckSAxpP3r6
         g8SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774476977; x=1775081777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQDzQb/gBIw+MDDDjq7X4ZU1Rk6doOJDsa8UP6sNnoE=;
        b=NauPbJ3N1oJh2Q82B04o58jfgVbuG2d1t3SUERHDZlWH0cfa7zN6nSbJcBY0j1+xYW
         0/DcpDk6CPzKnH8CTzdtCYtIRps3cj122vgqeKAFlcb118+W98JjQX4MUAcvTU4QhznU
         wc1x2qNN4NOidhYHC6dQQ3TJrlRN/lAL+9tPEXFkmYBHAvidFNuenXT4VSJYr6Myf97j
         4toRw8WB59f4WoqYbffafRmDeEYh+4AQUwkuOXA1VAN7CExJL8VoYq6vi/6bEz9frm72
         0oD1ZPXm5CLg8IUE4PVtZVeaQJ7WQlHMY7QgLFp4DzSDYLZuWrp+opvpUl+xbvHEfhiO
         h7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774476977; x=1775081777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQDzQb/gBIw+MDDDjq7X4ZU1Rk6doOJDsa8UP6sNnoE=;
        b=XFKvPBx3ydde5RYVJ7AZoSOmag94OrRfkrp+ZDRI0pBMP2rjb7Kry5dqmul5AMc+gk
         0KqkKuKYgTs31RfPTnU16zBFXDOTNcSM7zh1F58TBktfyHdujgwNZCGYdjI7QIceu0JE
         pw5W1YZxYs1OTYxbc2cYB0dvj7haDYigza12CWXNPOzTL2cBnd3oNt0qDJ306AnTaWEJ
         XQAMZZiY4XVRttDREW//iilf6zGQ96zbQp3PzcgroyeiFtELc4cDnc6uiXthX+zl+2Jo
         1HkgEuqq8P/US2dyQIMNkwmUpPbGhIOSJqTPcStF1Qv0dTMk7PuWFASlno5XI+s+BJrK
         tJYw==
X-Forwarded-Encrypted: i=1; AJvYcCU+VdyoWjpxHgtr6RY4LiRIGk96PJbdLjTWYyt5KbfVix2rdPOxAdVN+LtplZSIj94YEk91qs7/kfkZwjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVB9VJipBjxYVqBDjuV+MFMk+udzhZPuj5Q6Wn7y3NJg/HJ07
	0FyVgCZgD2cvu6tpAlDjBPQ5oObsOnjU3zEH7ObDwAGo7c4ZTJooGjNhPCqfyzBXWvHa6hxvGZk
	3LPxPSUBVVu3MtTEBHL4+qaCGTpfLbW35LnPDptIu
X-Gm-Gg: ATEYQzyT97KPhgGWjVeocKrFZo//U0pv3+mv9ln5oprZnJZy1VqTnOvBhqdTGa2dVo0
	V1L8tOyfG0oM1gF+u5VpAY5RsKOzayXc7kV69PLoV134AykedPeF3/yw0QfHFWStfEodlXOitM/
	pGzlXnQ54rzrX0pVSu3fAo/qr5ANOdL66X3Bnr32DmJoK4X0nUVpZoG2Jvyy13rBWTDORCulWlY
	VpHto0I5HJrBA60WUysqB3nCe0dXfU9BRSPnC7HzFJrwu0QUZ9COshccHa4IhSko9EUR3FjXB/u
	i9NidJfFFZ1iL9ZGRpDo1uQZJ2MjzUrEkNwwuw==
X-Received: by 2002:a4a:ef81:0:b0:67e:aa1:87fe with SMTP id
 006d021491bc7-67e0aa18de3mr609126eaf.26.1774476976932; Wed, 25 Mar 2026
 15:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com> <14-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <14-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 25 Mar 2026 18:16:05 -0400
X-Gm-Features: AQROBzA4qyqKM_YfcGn1wN202YeqdJ-wh9W4v93pqVeHVoUP6HSGLEO470XesXs
Message-ID: <CAHYDg1Rx_o5osDGWX0q_=BES4C-rpbhOXjfWcQV-yAOe38sn3Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] RDMA/irdma: Add missing comp_mask check in alloc_ucontext
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Bernard Metzler <bernard.metzler@linux.dev>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Gal Pressman <gal.pressman@linux.dev>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Michal Kalderon <mkalderon@marvell.com>, Michael Margolin <mrgolin@amazon.com>, 
	Nelson Escobar <neescoba@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>, 
	Chengchang Tang <tangchengchang@huawei.com>, Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Zhu Yanjun <zyjzyj2000@gmail.com>, Long Li <longli@microsoft.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9795-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A1B5432CD2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Jacob Moroni <jmoroni@google.com>

On Wed, Mar 25, 2026 at 5:27=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> irdma has a comp_mask field that was never checked for validity, check
> it.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index b2978632241900..d695130b187bdd 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -296,7 +296,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *u=
ctx,
>         if (udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
>                 return -EINVAL;
>
> -       ret =3D ib_copy_validate_udata_in(udata, req, rsvd8);
> +       ret =3D ib_copy_validate_udata_in_cm(udata, req, rsvd8,
> +                                          IRDMA_ALLOC_UCTX_USE_RAW_ATTR =
|
> +                                                  IRDMA_SUPPORT_WQE_FORM=
AT_V2);
>         if (ret)
>                 return ret;
>
> --
> 2.43.0
>
>

