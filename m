Return-Path: <linux-hyperv+bounces-6678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E30B3D49D
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D7C1887EA3
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E18270EA3;
	Sun, 31 Aug 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P284J3ij"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77071DFDE;
	Sun, 31 Aug 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661482; cv=none; b=OPmSl1gHW1ASp+BbKwpKDXNEKIqUjkk5bsfsWiRv8KJ5+6L/Ok6+PgdiF/QPh9tXRy2bVPYhkB3Z3QVJxaq2rbtj9Q6Rx7aNj11r+wJkozSiEXsFoOTtw/4IUfauSpmhtNDLOosGDIl50eA9LQvqEO9LKUlPtJrfhonb1aQ8UCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661482; c=relaxed/simple;
	bh=9R/gIDSvGAo0tnOio612OdWQxgFHok7GPgDa6V9IzTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5J46asFTWlSvLBBXbX/26dwNeoy8CDnZaC2jg9po4aGmhI9R3jH3yRPAcyODCy8bYlMzPilyqCKj5TAtfXRcCJOPLSVSXrhLoKRsawDxrN4g5+X/dUJIcxDyjHkZOmHrruSYXNeWAlaXvwz4ET9E4j/aurURoiHhsSsxe+DfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P284J3ij; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so3281243a12.0;
        Sun, 31 Aug 2025 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756661480; x=1757266280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J5tnGYqDn9eu0TWs8GwgpAdtaA2flto4lBb6OtEJ5I=;
        b=P284J3ijvajnOSaCFPTByiaRKrFHrjW/Fh1T4/05ZBwWw08jG1vdjF6G8rRMV+u60k
         ggFdleJtEvy2mChFLkhLAHmERKooMwmab2HUTCp+aG67XfdSuVycXD4yawy55RuMJJBE
         VV0GyNNzri8T4EoOejP5wY45L6PLq1d0qc61rjqmYNC00fJUEPS5d52LruUHjnZY3KzN
         mJ3Juq1HypC7l6RzBvFVGLrJOZlyTu5o8FNWIF8Gy/B7wRTIQAZAMUyRgkGVuetupBRC
         cSs1F1lyW6dWfslXS4RVHbMqYJXKtHQWtA7gbcYqcZVCMTF/Z4CKKmvN+7fathhNiyTT
         qHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756661480; x=1757266280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J5tnGYqDn9eu0TWs8GwgpAdtaA2flto4lBb6OtEJ5I=;
        b=U8D3QFgHYpFFMg21TCuGhMlI/7CxUOMcSFSn4cE5ta9jaUavY848K1MtD4P2DmyHdZ
         DjMVMQlBzlvGKu/CRPH5X9hgALUU0c0nKK11gmDOu+iuoXJGNImyUcSMwM9MNzfq8JqH
         tItJ165GD/jxOpPxRI6YJW/X66/JourZ4ebfJbetaHSoIKybidepYItnFs5HrwmKQ0mV
         Kzm2i3uI8t4xQBoayOWuMs4tpkDEYBH2qpUiOcuHf4Yd/WzMgaLPDYBbbFY0zrh5eSa7
         VQANAG4fiC+CW4pwC5olEtnhB59cvzpaK60JSKZpItIgVgD9WDZwec8BpsPkcsN2honB
         1xgg==
X-Forwarded-Encrypted: i=1; AJvYcCUeNKT4DbkUQK7V1JNiAnIO2hL3lFc956Vd8hzh2mGO94NTYftiyX6drHiW/VYGttE3R0k/phsm@vger.kernel.org, AJvYcCVXvs4gAj3oh25Mjygs2+iabzRx0TF1xyiyfB1rIsc8FfRa4WrIHsEK+KMBlI+a9v5ma+SXCTvZPuJJAWNr@vger.kernel.org, AJvYcCW3A8wwivq8BlrjuuK1gSHtvqRYfO0XSKWEpX1Ia0736vY3p5d/QGwhRnHGL7GnVMkfm+/SL7f+1jKLD9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbWOQmQI71ejlhLk36fGPsjQj1B1SDcn/69mGIexqQQi6yieR
	bEiF20vG5IJK4xyS+9/1ZVHhEh/FbCzePZVtn93Zx+2ii0jLrM7PXgmQ3afkmxKh13I4qdPVoaH
	TowGZSDby2tPNroTrGK4iybupyIokQEk=
X-Gm-Gg: ASbGncueanCbN77xGJAQQnS65UlfadqC0ZxuEvan3XFjvgmXv/78vOdSVC1UABUR6fj
	ltsHYTiZTOcPucTd4PjDRVGtA2Rwcp+LYBWMCjbXZZOv2ZQ4q4k0w+Qk2p9NHpD0Kfg4qvg0Rg0
	RQH+0ixuXij+haCO6vXD4RrWrQapXJl9wBRHGdChhGJ+tTkjJ0GDsHwMZgDif4YT6LoQeNkYiek
	vUsBQPTOWTwVvSre+c=
X-Google-Smtp-Source: AGHT+IH7JYUwECPVluGNmsmL/DuZUg5eOk43rP0j84gusZSSfSrD4JREcL7++kUd3p6aw3fjSlExji83/E02rq8szW0=
X-Received: by 2002:a17:902:d549:b0:240:6fc0:3421 with SMTP id
 d9443c01a7336-2494486f594mr84845425ad.3.1756661479892; Sun, 31 Aug 2025
 10:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828044200.492030-1-namjain@linux.microsoft.com>
In-Reply-To: <20250828044200.492030-1-namjain@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 1 Sep 2025 01:30:44 +0800
X-Gm-Features: Ac12FXyAZjZnyqi8DKZcVw2CqYH4G9SRJFbrKuhxYxDA1TEhpgLaikV9hYstbuc
Message-ID: <CAMvTesBUJb1xpCuyORzDb0EdrDbkkOpkXB0ZYG5ktbN+LbJtHA@mail.gmail.com>
Subject: Re: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt mask
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 12:42=E2=80=AFPM Naman Jain <namjain@linux.microsof=
t.com> wrote:
>
> Remove the logic to set interrupt mask by default in uio_hv_generic
> driver as the interrupt mask value is supposed to be controlled
> completely by the user space. If the mask bit gets changed
> by the driver, concurrently with user mode operating on the ring,
> the mask bit may be set when it is supposed to be clear, and the
> user-mode driver will miss an interrupt which will cause a hang.
>
> For eg- when the driver sets inbound ring buffer interrupt mask to 1,
> the host does not interrupt the guest on the UIO VMBus channel.
> However, setting the mask does not prevent the host from putting a
> message in the inbound ring buffer. So let=E2=80=99s assume that happens,
> the host puts a message into the ring buffer but does not interrupt.
>
> Subsequently, the user space code in the guest sets the inbound ring
> buffer interrupt mask to 0, saying =E2=80=9CHey, I=E2=80=99m ready for in=
terrupts=E2=80=9D.
> User space code then calls pread() to wait for an interrupt.
> Then one of two things happens:
>
> * The host never sends another message. So the pread() waits forever.
> * The host does send another message. But because there=E2=80=99s already=
 a
>   message in the ring buffer, it doesn=E2=80=99t generate an interrupt.
>   This is the correct behavior, because the host should only send an
>   interrupt when the inbound ring buffer transitions from empty to
>   not-empty. Adding an additional message to a ring buffer that is not
>   empty is not supposed to generate an interrupt on the guest.
>   Since the guest is waiting in pread() and not removing messages from
>   the ring buffer, the pread() waits forever.
>
> This could be easily reproduced in hv_fcopy_uio_daemon if we delay
> setting interrupt mask to 0.
>
> Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1,
> there=E2=80=99s a race condition. Once user space empties the inbound rin=
g
> buffer, but before user space sets interrupt_mask to 0, the host could
> put another message in the ring buffer but it wouldn=E2=80=99t interrupt.
> Then the next pread() would hang.
>
> Fix these by removing all instances where interrupt_mask is changed,
> while keeping the one in set_event() unchanged to enable userspace
> control the interrupt mask by writing 0/1 to /dev/uioX.
>
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Suggested-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20250818064846.271294-1-namjain@linux.microso=
ft.com/
> * Added Fixes and Cc stable tags.
> ---
>  drivers/uio/uio_hv_generic.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index f19efad4d6f8..3f8e2e27697f 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -111,7 +111,6 @@ static void hv_uio_channel_cb(void *context)
>         struct hv_device *hv_dev;
>         struct hv_uio_private_data *pdata;
>
> -       chan->inbound.ring_buffer->interrupt_mask =3D 1;
>         virt_mb();
>
>         /*
> @@ -183,8 +182,6 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
>                 return;
>         }
>
> -       /* Disable interrupts on sub channel */
> -       new_sc->inbound.ring_buffer->interrupt_mask =3D 1;
>         set_channel_read_mode(new_sc, HV_CALL_ISR);
>         ret =3D hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
>         if (ret) {
> @@ -227,9 +224,7 @@ hv_uio_open(struct uio_info *info, struct inode *inod=
e)
>
>         ret =3D vmbus_connect_ring(dev->channel,
>                                  hv_uio_channel_cb, dev->channel);
> -       if (ret =3D=3D 0)
> -               dev->channel->inbound.ring_buffer->interrupt_mask =3D 1;
> -       else
> +       if (ret)
>                 atomic_dec(&pdata->refcnt);
>
>         return ret;
> --
> 2.34.1
>
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Tested-by: Tianyu Lan <tiala@microsoft.com>
--
Thanks

Tianyu Lan

