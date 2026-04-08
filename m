Return-Path: <linux-hyperv+bounces-10088-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMhiD5uZ1mmgGggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10088-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 20:08:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1C3BFFC9
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABEE3063563
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F63D9039;
	Wed,  8 Apr 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ervxnadA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx/t7Qg3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE773D8125
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Apr 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671569; cv=none; b=ItYAO/X85yjhYwaalaryjqfPmUpkjUViN6j5x4c8Hyu/rSbxlGqWaPds601PGFmEQbvG+e/Fg7mzzzlLTFWxWtid5Ny8LRzq8tHaUf4LfX7rcHiQzugGKYDSEhtfNs+KskDIh7h8F3tvzW3gjjXTKux5vLYFPb9iELeB5AYbKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671569; c=relaxed/simple;
	bh=RXQNw5Y8OwY4npADqwxMqxkPkSXSX91b0ZjH4yw4r/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AF3/8nS/4JqdQzeHQYII9fH4FvG3kUQWe5k0RCtTNq5TWohhN0E1dcLXwWxgcBQqZYMsr8Vx8KZ4M+up02aBHxtZZm67da57Ak0igRAVChy/apWOD2AAfdSR83C0UIrYXYQb6bG569PjXfU3x5qIfazLPvgR8u/ADsKFLB7qBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ervxnadA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx/t7Qg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775671566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp3qpXCVrq/PH/jAwKXNkKIDqgP+CrVei//cW2ICbL8=;
	b=ervxnadAvNwi5cuboLZfnaFTkKKdB4yid2W9qILpDBko9qmqb7sQvKFhx/Lt1accdTSwkx
	E8wrVcRTaMx2mZJAn19lg7oC9PlvJCgk/D2z23sfKADrxtWa+iQfhVVeqDZPVE4k2SXZFQ
	VGs3puigQQ0DYdT/BGmHFIJftsa8HGY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-nmBTJAUwMDi6CPJYOWNelw-1; Wed, 08 Apr 2026 14:06:04 -0400
X-MC-Unique: nmBTJAUwMDi6CPJYOWNelw-1
X-Mimecast-MFC-AGG-ID: nmBTJAUwMDi6CPJYOWNelw_1775671564
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b220c72bbso1772371cf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Apr 2026 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775671564; x=1776276364; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yp3qpXCVrq/PH/jAwKXNkKIDqgP+CrVei//cW2ICbL8=;
        b=Qx/t7Qg3OV6Ckar8WrYZH5mB9EXHV/B631/Gxng14w30FRCt4ofGmW4LuUIEvqu1dG
         Sxrlb82GUPFlUs/uEBJxb8oX8va1X/HrkSa9r9x9/zvS4LNYLdBRvd8UKf9xsVILt6EM
         0ijVHYLVFKkXM9tbMRclrnGLQRp6stopF1+aMh9KCVltF0Kv8KPRRBpqb8Vp41YKdrzJ
         ijTdlSNm68sEBPI7X7Y33CzskjZKejJV7dv2j4eDq/QQltO5RTgbzOP22pI1Vayhuzsg
         Yi457Z6zdH+qMP01jsxgrWnickr9yIT+0iFe3X94D4Xoa6cU+Hzm16gxPOoPqC4y4j5V
         Q82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775671564; x=1776276364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp3qpXCVrq/PH/jAwKXNkKIDqgP+CrVei//cW2ICbL8=;
        b=BimSvg+dYmrg6NAEJysqodvEgAyIRuLWMAEZdE8Gw7JjBgnNo1DnOsG0DC18t5cn69
         i/KIr1qkulvrLnOeGg4m/nXdxme34ygIxTg70SFGjqu8V5hkc/6a/uzpdTyPokJI5Gzi
         1dXNjA5QtqQYJf/RcsTBbi9T31FtO23FSz1hyVFPwOCUw9KG9X58mbrDjRO5TdnJBa7F
         Nikb/bTFfdXoPxxUUm1FdLi3BFCJ2D9jYDpRnn+VtR+qSo7n3MpriK/IuTQDdUf3Pkt/
         hXBUZdZRIucH4N67Y6oqDmTTziCERSF3NcZC9///ihSrCguK2Z3nH/RrML+8wpzjCsFT
         bo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi/0FCaTDrGdK3UurxaKgJlSKjwXRU0iEqwQ2ZreMDDtcbkvvb+0w5N/B2e6QthTtnSVK9cuoLzLAzdw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlu/YjNuTQlMMO4UrCMiCv5tUkkSZeQLOynrnnzzglT44KSBge
	6k5dM4lh/8EGTWE7weehOkV3s6VHOuKoJ3rWOWW/HwyvwHu5NxJOd5kE+jGM/iht28bROWHhrEH
	KE6O0Scw1Y8YxYx6iIrEOL1kCz++ejSBl/VCih+Zu8FbR8g07Ve6RyECDEnBr/UvdVA==
X-Gm-Gg: AeBDieuDE6ZPzlipaI7AErfaOmPH8zFQvGhCE8g8d3JALDTG0abHXnS4a9DI864+T4/
	iXY+GweQ3rfMc3vQv8gqXJpPjPoay6hee51Imus0RizBgYbqB9i9ju0t5VMb+zVJG2xo7JCMCzP
	MWf/hlXPC6jh335ztbXbTQRyzZGSGT5jeHcEY6+CiNPtztrdyMjj6dQlSsC0H4ardLuN7WLSXUE
	e5Qz2qjFKYf/IfO01QjA5N+uF1BTPkl6uPyIRob6PSIIA89smFGiVS4HaewZ/qMOQvWV4LsWZr9
	/dFJKVOGSR+27TamNlMta9Q53mZ+xAzeD+G+RvJG+wVDar5/GL9LZB9E1jXRThv/V+qLmB8dCST
	CvawxYW2pRr1a4frFKU2GO++z0TktkN/pi3WkG7mz/9ALQ95NcMBshjtSeZk=
X-Received: by 2002:a05:622a:203:b0:509:1ffc:c538 with SMTP id d75a77b69052e-50dc219b2d4mr6056771cf.19.1775671563615;
        Wed, 08 Apr 2026 11:06:03 -0700 (PDT)
X-Received: by 2002:a05:622a:203:b0:509:1ffc:c538 with SMTP id d75a77b69052e-50dc219b2d4mr6055861cf.19.1775671562963;
        Wed, 08 Apr 2026 11:06:02 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c64:4e7f:603b:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b93dd10sm166685151cf.7.2026.04.08.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:06:00 -0700 (PDT)
Message-ID: <238f847ffecf093f0476bc04fbd19d626c574d85.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN
 truncation for Hyper-V vFC
From: Laurence Oberman <loberman@redhat.com>
To: Long Li <longli@microsoft.com>, Li Tian <litian@redhat.com>, 
 "linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>,  Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <DECUI@microsoft.com>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"	
 <martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"	
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Wed, 08 Apr 2026 14:06:00 -0400
In-Reply-To: <SA1PR21MB6683ABEAC8B490387658B7C7CE5AA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260406015344.12566-1-litian@redhat.com>
	 <SA1PR21MB6683ABEAC8B490387658B7C7CE5AA@SA1PR21MB6683.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-10088-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loberman@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hansenpartnership.com:email]
X-Rspamd-Queue-Id: 71F1C3BFFC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 22:30 +0000, Long Li wrote:
>=20
>=20
> > -----Original Message-----
> > From: Li Tian <litian@redhat.com>
> > Sent: Sunday, April 5, 2026 6:54 PM
> > To: linux-scsi@vger.kernel.org
> > Cc: Li Tian <litian@redhat.com>; KY Srinivasan <kys@microsoft.com>;
> > Haiyang
> > Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> > Dexuan Cui
> > <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; James E.J.
> > Bottomley
> > <James.Bottomley@HansenPartnership.com>; Martin K. Petersen
> > <martin.petersen@oracle.com>; linux-hyperv@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [EXTERNAL] [PATCH] scsi: storvsc: Handle
> > PERSISTENT_RESERVE_IN
> > truncation for Hyper-V vFC
> >=20
> > The storvsc driver has become stricter in handling SRB status codes
> > returned by
> > the Hyper-V host. When using Virtual Fibre Channel (vFC)
> > passthrough, the host
> > may return SRB_STATUS_DATA_OVERRUN for PERSISTENT_RESERVE_IN
> > commands if the allocation length in the CDB does not match the
> > host's expected
> > response size.
> >=20
> > Currently, this status is treated as a fatal error, propagating
> > Host_status=3D0x07 [DID_ERROR] to the SCSI mid-layer. This causes
> > userspace
> > storage utilities (such as sg_persist) to fail with transport
> > errors, even when the
> > host has actually returned the requested reservation data in the
> > buffer.
> >=20
> > Refactor the existing command-specific workarounds into a new
> > helper function,
> > storvsc_host_mishandles_cmd(), and add PERSISTENT_RESERVE_IN to the
> > list of
> > commands where SRB status errors should be suppressed for vFC
> > devices. This
> > ensures that the SCSI mid-layer processes the returned data buffer
> > instead of
> > terminating the command.
> >=20
> > Signed-off-by: Li Tian <litian@redhat.com>
>=20
> Reviewed-by: Long Li <longli@microsoft.com>
>=20
>=20
> > ---
> > =C2=A0drivers/scsi/storvsc_drv.c | 32 +++++++++++++++++++++-----------
> > =C2=A01 file changed, 21 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/scsi/storvsc_drv.c
> > b/drivers/scsi/storvsc_drv.c index
> > ae1abab97835..6977ca8a0658 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1131,6 +1131,26 @@ static void
> > storvsc_command_completion(struct
> > storvsc_cmd_request *cmd_request,
> > =C2=A0		kfree(payload);
> > =C2=A0}
> >=20
> > +/*
> > + * The current SCSI handling on the host side does not correctly
> > handle:
> > + * INQUIRY with page code 0x80, MODE_SENSE / MODE_SENSE_10 with
> > cmd[2]
> > +=3D=3D 0x1c,
> > + * and (for FC) MAINTENANCE_IN / PERSISTENT_RESERVE_IN
> > passthrough.
> > + */
> > +static bool storvsc_host_mishandles_cmd(u8 opcode, struct
> > hv_device
> > +*device) {
> > +	switch (opcode) {
> > +	case INQUIRY:
> > +	case MODE_SENSE:
> > +	case MODE_SENSE_10:
> > +		return true;
> > +	case MAINTENANCE_IN:
> > +	case PERSISTENT_RESERVE_IN:
> > +		return hv_dev_is_fc(device);
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > =C2=A0static void storvsc_on_io_completion(struct storvsc_device
> > *stor_device,
> > =C2=A0				=C2=A0 struct vstor_packet
> > *vstor_packet,
> > =C2=A0				=C2=A0 struct storvsc_cmd_request
> > *request) @@ -
> > 1141,22 +1161,12 @@ static void storvsc_on_io_completion(struct
> > storvsc_device *stor_device,
> > =C2=A0	stor_pkt =3D &request->vstor_packet;
> >=20
> > =C2=A0	/*
> > -	 * The current SCSI handling on the host side does
> > -	 * not correctly handle:
> > -	 * INQUIRY command with page code parameter set to 0x80
> > -	 * MODE_SENSE and MODE_SENSE_10 command with cmd[2] =3D=3D
> > 0x1c
> > -	 * MAINTENANCE_IN is not supported by HyperV FC
> > passthrough
> > -	 *
> > =C2=A0	 * Setup srb and scsi status so this won't be fatal.
> > =C2=A0	 * We do this so we can distinguish truly fatal failues
> > =C2=A0	 * (srb status =3D=3D 0x4) and off-line the device in that
> > case.
> > =C2=A0	 */
> >=20
> > -	if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
> > -	=C2=A0=C2=A0 (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> > -	=C2=A0=C2=A0 (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE_10) ||
> > -	=C2=A0=C2=A0 (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
> > -	=C2=A0=C2=A0 hv_dev_is_fc(device))) {
> > +	if (storvsc_host_mishandles_cmd(stor_pkt->vm_srb.cdb[0],
> > device)) {
> > =C2=A0		vstor_packet->vm_srb.scsi_status =3D 0;
> > =C2=A0		vstor_packet->vm_srb.srb_status =3D
> > SRB_STATUS_SUCCESS;
> > =C2=A0	}
> > --
> > 2.53.0
>=20

Looks good, rewrite of how it was done before but will achieve the same
behavior we wanted for the new addition for PR.

Reviewed-by: Laurence Oberman <loberman@redhat.com>


