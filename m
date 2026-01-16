Return-Path: <linux-hyperv+bounces-8330-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C0D2B18E
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 05:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA26E301618D
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 04:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9B344039;
	Fri, 16 Jan 2026 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iHb5lXvC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1A33C538
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536015; cv=pass; b=gNpbjiGV2ruVFJC0cmpjIR+tCb092aQ/gUIodxGDn6pWmH0hw40rYtcDyxdtEs5HWN5NGEgz1A6+hC1F6zov5mQeKLdaVQVtHXywdcspMUyNDt25TbWvDTvDO7LrFn/2ei9JCdIunQ0QZ3AQPbtjpQYouQAy5AlXvUMNWzL/fSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536015; c=relaxed/simple;
	bh=Sa6H3SoWeLBzKsO/fGnw23QkkbfZS0rF8cwCHV7DC18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P486ROFfvKiVa0a9+t6MzisQfiiDyOG4SslQ0oXEqMHsAwT22ivVv5OHKLmKVjBTsrSETv8PV8hWmbVahG0IdwPt+e3XJZpm5zEUY+DseQ6sP6O2F9EyHto/NUe27DDJxRiyKNc0w7om6fBH35OvlJGk9EB925iG9R036vxhS8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iHb5lXvC; arc=pass smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7cfd8ca8191so483043a34.3
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Jan 2026 20:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768536013; x=1769140813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa6H3SoWeLBzKsO/fGnw23QkkbfZS0rF8cwCHV7DC18=;
        b=KbVfhz17/m+LSJ3jMRa+ysrC55la56qnrsLhYhmjIV8W4bOUG/71MAyTKiPwqNc0y8
         GJS9lsvD/JIKaBPKtckhb5b+5AfVW3TUxyf/Uj7hju/WziYJaav1RZYcvk3JLfmP/kt1
         ZHVXDCd98SmDMOf9ofst18GZA4G15lEZGI1J6glFUtKe+OIEeKMPKuYvHeC5gXDfwDLx
         3jUFp1HhwBA66ws989PRkBPi5e7EZLtCcLETPgK50pi+YwDoSCOGFe93F8lxcIPF4Cff
         4ipJ6O6N/BcXF83SUpppmE/8WZPXlHgURuIxSE6Qv55sZRPIHdbFvghLxWlBGxo0wg69
         zNDQ==
X-Forwarded-Encrypted: i=2; AJvYcCX1F5jVHlGnT44TaC+xBFtKtOMkTnOIzPRTCzFYhiTYMB2PWf/DfDaoMBqayfipmXYrD/Wx+fKPlNq/ha4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cnO68EqZjJ2FvdmGSK4X1R3qo8Kaut6eOItCfJkpPf2ixLfH
	maE9TFgUtWgOuLW+9R5Q8suthMVFPEQzTbHiVBNshsjHs77FGOOfQrkTgJ8IplKCNXdJPkKqItP
	xnouQghhQ/aopKCFdH5FzyHMIEGsBqqE9jwPyHeNdnFURSlsvcM9WKx1Z9XIZ4yoKa07oSI2f7Y
	QNIMRBCPeaG2Hw2zgyVx3id96Ae14auGcs7QdiGczZrS4B7TPAvcTemnXkIGQrlw4kL42scImp2
	Ips8fg8AFGPw41x
X-Gm-Gg: AY/fxX40UwWPuOgMSjlayv+C9hVHoZCSD7N3gESR9deiu4e66TcWHPkTNM7bfdeR/0M
	FuaAOF42C0QF/sutx6o8vg+SdFYrPACnOZULAEHjmG4mz2L4sg3qLtdQSjug73e5VIzAoe/zjnr
	M/WlB0a+QSMxMK2BYJDg3EuiYpFEsUq64Xm5aDQGL8Sr84KEJ9o8VRomBj0bQHzfz/W6mR0rwFE
	AxFDpRNiLHBqsYGidSJAEDG/8RxF+G/xbOC3GzxuUeTGEo6f4GyEZ3SiKs60J6yGS4xJdTSenI3
	Bhh1hZJ6wNgQ9BugWp94KAMpNFkjQV7H4mS+N+ncjU+hlOrTEjTUT4RhPdiWGTbBMkiBdiDBdsK
	S6t4S4h5HcBH+23XxPZjzf7iPA4mQJ7dCFq6SFiAN0sAZQ2dHel7F6YMDWSoTEXcv9sE2twyQVE
	+4WWE2L0uyqQLYrivmlvbZN+2h8OP1DUvywj1A+x8=
X-Received: by 2002:a05:6830:82cc:b0:7cf:c485:be43 with SMTP id 46e09a7af769-7cfe00d8b60mr734045a34.7.1768536013038;
        Thu, 15 Jan 2026 20:00:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cfdf2a2511sm152569a34.3.2026.01.15.20.00.12
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 20:00:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59b6849824dso1305157e87.1
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Jan 2026 20:00:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768536011; cv=none;
        d=google.com; s=arc-20240605;
        b=IbK3PhJpzjl01sQ9I5EOB8IBmsRuUgQW93M71GZtLNPsxjXUB3qjoVJ9NgtmKZaBHs
         YNtX0Dh+i1wuZ2q7lG+sXFcMvvevigD1zFgrA/OruUHKkd9LhCPdb7Nb5yfUDlH4nWVc
         yRaMDiDi/PhRuY2DTbB36x1QQV1yBlwbJAq+KZSh+0HyW3jdz7qalPdUAZtpKM06cUS0
         RvKFtgTqL0h/+ns0Lw6/i4SPivdgu4tirtBNCWRwLhsXiPWyqgic/JG5R3iiE+53yCW9
         h+dLEGnH0nFBo6vWB5iTEc4bjZajsjECmLjwED+MhEyPa+gH9qQZto8CJqdJuZAlM7vm
         B6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sa6H3SoWeLBzKsO/fGnw23QkkbfZS0rF8cwCHV7DC18=;
        fh=lKzZAYFQcwod9RdaJwVVTk3eNKpDnGHtvJOTQ/4ChYM=;
        b=R3mhe4uqtkztZMk/D21c8tMQobxGwR1OxMDq3XR6lD41aIBvAdAg/32dUw1M7qZZ8e
         6ftIsKtA0vDuF3fMdD9ns6u20WVL1LOUECInJbK24qXBR9DNKrB3ZdO09SA4kYg7VGDo
         BLl8cSsFJmgr7BlpHs6VFpivp+Wvlp0JVMHG3UbPh++8kfTCJjm2JvHeWQMouABQNZuh
         BZfmQwIxDit/U3wnT5ml+y7pUhnw0b8Cnzq5MWlnLOqzF/snxPaXxPVTUKNFPXW+a6rk
         6SxN9h3CnuYCp7ia9dcUnhxoQNLYMPqwrloGZ3zUCjaF1YuP1hl27ATbdYoGS5ahNpgX
         76Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768536011; x=1769140811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa6H3SoWeLBzKsO/fGnw23QkkbfZS0rF8cwCHV7DC18=;
        b=iHb5lXvCqx6jLyNalJI4Rd9Ik/nVEH1lrsBo85LARRJwANqp+gddY4UkUJy2jOpJV6
         AjrwztTOqof36FrEq8DzUxNrz/D9HaisNMkkWALWRLmHMv/lB7tjfxTLpwKyl83u6hUc
         Wc3xQ+wvgaRHclyslYK/3bbjZemXrB4c07m24=
X-Forwarded-Encrypted: i=1; AJvYcCX61ACG67gKxqjCTm6Q7eFhJ0Ffjhjhc4bvvBwGMBtuAsAoMcFFjN+9vQ7bu/faTH5cDI2JrSZ59JRr6BA=@vger.kernel.org
X-Received: by 2002:a05:6512:110f:b0:59b:7c23:c637 with SMTP id 2adb3069b0e04-59baeedb316mr473010e87.22.1768536010919;
        Thu, 15 Jan 2026 20:00:10 -0800 (PST)
X-Received: by 2002:a05:6512:110f:b0:59b:7c23:c637 with SMTP id
 2adb3069b0e04-59baeedb316mr473003e87.22.1768536010460; Thu, 15 Jan 2026
 20:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de> <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
In-Reply-To: <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 15 Jan 2026 22:59:58 -0500
X-Gm-Features: AZwV_Qi80DLh5-dVzEeXXXwxSJzK4tEf9_V9qKxKCqReQ_R-wGE0BF4WXFFKv3w
Message-ID: <CABQX2QMn_dTh2h44LRwB7+RxGqK3Jn+QCx38xWrzpNJG5SZ9-Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>, 
	Chia-I Wu <olvaffe@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Deepak Rawat <drawat.floss@gmail.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>, Helge Deller <deller@gmx.de>, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	spice-devel@lists.freedesktop.org, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	=?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bad4c906487960a7"

--000000000000bad4c906487960a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:02=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> That's really not going to work. For example, in the current series, you
> invoke devm_aperture_remove_conflicting_pci_devices_done() after
> drm_mode_reset(), drm_dev_register() and drm_client_setup().

That's perfectly fine,
devm_aperture_remove_conflicting_pci_devices_done is removing the
reload behavior not doing anything.

This series, essentially, just adds a "defer" statement to
aperture_remove_conflicting_pci_devices that says

"reload sysfb if this driver unloads".

devm_aperture_remove_conflicting_pci_devices_done just cancels that defer.

You could ask why have
devm_aperture_remove_conflicting_pci_devices_done at all then and it's
because I didn't want to change the default behavior of anything.

There are three cases:
1) Driver fails to load before
aperture_remove_conflicting_pci_devices, in which case sysfb is still
active and there's no problem,
2) Driver fails to load after aperture_remove_conflicting_pci_devices,
in which case sysfb is gone and the screen is blank
3) Driver is unloaded after the probe succeeded. igt tests this too.

Without devm_aperture_remove_conflicting_pci_devices_done we'd try to
reload sysfb in #3, which, in general makes sense to me and I'd
probably remove it in my drivers, but there might be people or tests
(again, igt does it and we don't need to flip-flop between sysfb and
the driver there) that depend on specifically that behavior of not
having anything driving fb so I didn't want to change it.

So with this series the worst case scenario is that the driver that
failed after aperture_remove_conflicting_pci_devices changed the
hardware state so much that sysfb can't recover and the fb is blank.
So it was blank before and this series can't fix it because the driver
in its cleanup routine will need to do more unwinding for sysfb to
reload (i.e. we'd need an extra patch to unwind the driver state).
There also might be the case of some crazy behavior, e.g. pci bar
resize in the driver makes the vga hardware crash or something, in
which case, yea, we should definitely skip this patch, at least until
those drivers properly cleanup on exit.

z

--000000000000bad4c906487960a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPhs
Q+k2q3KtslWtYwB+RUVZOSs9Q+p5fc1jjMFKwfpoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDExNjA0MDAxMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIzDYYUyCyT9dVC6l4aOs54ywGPVFxwPwFcTShF7
JVRsxKBn2MEcv5TlwbINsyXRmEsPTt4lA3puz+6l4a1rEoDbbUuwQcbhvu8dFfVY/LN8iufyONP1
U2l05F64PZdGNqeAuhIKGxEH42Hv84/C0LRnt/48nSVm28/wuxMzLJoZbSD0NVkRSIHmVSgUCta1
5EqWp67P8p7/I/tKzcVlLURhjjHDJrw5q09Po+eatyqoOqJURszYGB0syJeHpzTbpzzgRqV/3WPL
LY8PIbn2EBQxQrQs4V92L1oLMJJqSLTJBcKYlI6RZBf2BhEhsa1ackwRE7jBlDUgSXpWbRMaeuk=
--000000000000bad4c906487960a7--

