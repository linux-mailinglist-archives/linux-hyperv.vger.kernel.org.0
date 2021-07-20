Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A173E3CFABE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhGTMzf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 08:55:35 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:46690 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbhGTMyk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 08:54:40 -0400
Received: by mail-wm1-f45.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so2059782wms.5;
        Tue, 20 Jul 2021 06:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QoG0e098CSVJM53LvmbZvNHBulV5BXavIcXXWl309i0=;
        b=FJnT4+N5S0v+SDDOqbvtQyc5rUBxwD6CL+EXda3aKlqUeaV7MVOiXWmR/6T2FMJ3Z+
         N0WK86EP9qfDQjz+++6/5g4r7GwANgSmM8Hwd9tO5kpbHgMSAJHj1E5WYE868s8KMkio
         JoHfxIZftt0G/ky4ZH4Vgk1pJi9/sfEu95bdUkgQ0HCySTzjWkdtd9+RLjvHP4PgOzTl
         dy6mAg8b3ZNLQy3KXfyJVmUXxK2K7O717BzIR8tADxh/igJ/oKFZ5pbPFzWWXcDrE1nK
         f0cZ6/SR/sejL655J98/OtMXrLpR1o5EQRf5rWu+FqshNUD+0A6vn/sOSvCBV6VNUEbF
         yopg==
X-Gm-Message-State: AOAM533mFutnhwlJFMR1c+XW7oHHfBxkbIDUp3W1zmeUVMeVXtvDMLmX
        +BJ9ELp9roYWaW6W985FDM0=
X-Google-Smtp-Source: ABdhPJytGN+Gdm4grFjtPtQw9ml8TJC1/WOjpBANA4AxN72OAWidJpkNxMAMxuV9RFN74AiTrf+hxQ==
X-Received: by 2002:a7b:c41a:: with SMTP id k26mr37800868wmi.117.1626788116253;
        Tue, 20 Jul 2021 06:35:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f15sm2440789wmj.15.2021.07.20.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:35:15 -0700 (PDT)
Date:   Tue, 20 Jul 2021 13:35:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Message-ID: <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 06:55:56PM +0530, Praveen Kumar wrote:
[...]
> > 
> >> +	if (hv_root_partition &&
> >> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
> > 
> > Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
> > kernel check this too?
> 
> Yes, you are right. Will update this in v2. thanks.

Please split adding this check to its own patch.

Ideally one patch only does one thing.

Wei.

> 
> > 
> > Wei.
> > 
> 
> Regards,
> 
> ~Praveen.
